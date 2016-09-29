<?php
/**
 * 管理后台账户、权限业务封装。
 * -- 1、管理员管理。
 * -- 2、角色管理。
 * -- 3、资源管理（菜单）。
 * -- 4、角色权限。
 * -- 5、管理员操作日志。
 *
 * @author winerQin
 * @date 2016-09-25
 */

namespace common\services;

use Yii;
use common\YCore;
use common\models\Menu;
use common\models\AdminRolePriv;
use common\models\Admin;
use common\YUrl;
class AdminService extends BaseService {

    /**
     * 退出登录。
     */
    public static function logout() {
        $admin_cookie_domain = YUrl::getDomainName(false);
        $valid_time = $_SERVER['REQUEST_TIME'] - 3600;
        setcookie('admin_token', '', $valid_time, '/', $admin_cookie_domain);
    }

    /**
     * 检查用户权限。
     * -- 1、在每次用户访问程序的时候调用。
     *
     * @param string $module_name 模块名称。
     * @param string $ctrl_name 控制器名称。
     * @param string $action_name 操作名称。
     * @return array 基本信息。
     */
    public static function checkAuth($module_name, $ctrl_name, $action_name) {
        // [1] token解析
        $token = isset($_COOKIE['admin_token']) ? $_COOKIE['admin_token'] : '';
        $token_params = self::parseToken($token);
        $admin_id = $token_params['admin_id'];
        $password = $token_params['password'];
        $access_time = $_SERVER['REQUEST_TIME'];
        // [2] 用户存在与否判断
        $admin_model = new Admin();
        $admin_info = $admin_model->fetchOne([], [
            'admin_id' => $admin_id,
            'status' => 1
        ]);
        if (empty($admin_info)) {
            self::logout();
            YCore::exception(6002101, '账号不存在或已经被禁用');
        }
        if ($password != $admin_info['password']) {
            self::logout();
            YCore::exception(6002102, '您的密码被修改,请重新登录');
        }
        // [3] token是否赶出了超时时限
        $cache = YCore::getCache();
        $cache_key_token = "admin_token_key_{$admin_id}";
        $cache_key_time  = "admin_access_time_key_{$admin_id}";
        $cache_token     = $cache->get($cache_key_token);
        if ($cache_token === false) {
            self::logout();
            YCore::exception(6002103, '您还没有登录');
        }
        if ($cache_token === null) {
            self::logout();
            YCore::exception(6002104, '登录超时,请重新登录');
        }
        if ($cache_token != $token) {
            self::logout();
            YCore::exception(6002105, '您的账号已在其他地方登录');
        }
        $ok = self::checkMenuPower($admin_info['roleid'], $module_name, $ctrl_name, $action_name);
        if (! $ok) {
            YCore::exception(6002106, '您没有权限执行此操作');
        }
        self::setAuthTokenLastAccessTime($admin_id, $token, $access_time);
        $data = [
            'admin_id'    => $admin_info['admin_id'],
            'realname'    => $admin_info['realname'],
            'username'    => $admin_info['username'],
            'mobilephone' => $admin_info['mobilephone'],
            'roleid'      => $admin_info['roleid']
        ];
        return $data;
    }

    /**
     * 检查指定角色的菜单权限。
     *
     * @param number $roleid 角色ID。
     * @param string $module_name 模块名称。
     * @param string $ctrl_name 控制器名称。
     * @param string $action_name 操作名称。
     * @return boolean
     */
    private static function checkMenuPower($roleid, $module_name, $ctrl_name, $action_name) {
        if ($roleid == 1) {
            return true; // 超级管理员组拥有绝对的权限。
        }
        $menu_model = new Menu();
        $where = [
            'c' => $ctrl_name,
            'a' => $action_name
        ];
        $menu_info = $menu_model->fetchOne([], $where);
        if (empty($menu_info)) {
            return false;
        }
        $where = [
            'roleid'  => $roleid,
            'menu_id' => $menu_info['menu_id']
        ];
        $admin_role_priv = new AdminRolePriv();
        $priv = $admin_role_priv->fetchOne([], $where);
        if (empty($priv)) {
            return false;
        }
        return true;
    }

    /**
     * 设置auth_token最后的访问时间。
     *
     * @param int $admin_id 管理员ID。
     * @param string $auth_token auth_token。
     * @param int $access_time 最后访问时间戳。
     * @return void
     */
    private static function setAuthTokenLastAccessTime($admin_id, $auth_token, $access_time) {
        $cache_time      = YCore::getDict('admin_logout_time') * 60;
        $cache_key_token = "admin_token_key_{$admin_id}";                   // 用户保存auth_token的缓存键。
        $cache_key_time  = "admin_access_time_key_{$admin_id}";             // 用户保存最后访问时间的缓存键。
        Yii::$app->cache->set($cache_key_token, $auth_token, $cache_time);
        Yii::$app->cache->set($cache_key_time, $access_time, $cache_time);
    }

    /**
     * 加密密码。
     *
     * @param string $password 密码明文。
     * @param string $salt 密码加密盐。
     * @return string
     */
    private static function encryptPassword($password, $salt) {
        return md5(md5($password) . $salt);
    }

    /**
     * 生成Token。
     * -- 1、token只分接口与非接口两种模式。
     *
     * @param int $admin_id 管理员ID。
     * @param string $password 用户表password字段。
     * @return string
     */
    private static function createToken($admin_id, $password) {
        $str = "{$admin_id}\t{$password}";
        return YCore::sys_auth($str, 'ENCODE', '', 0);
    }

    /**
     * 解析Token。
     *
     * @param string $token token会话。
     * @return array
     */
    private static function parseToken($token) {
        $data = YCore::sys_auth($token, 'DECODE');
        $data = explode("\t", $data);
        if (count($data) != 2) {
            YCore::exception(6004003, '登录超时,请重新登录');
        }
        $result = [
            'admin_id' => $data[0],  // 用户ID。
            'password' => $data[1]   // 加密的密码。
        ];
        return $result;
    }
}