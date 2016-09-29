<?php
/**
 * URL相关封装。
 * @author winerQin
 * @date 2016-04-05
 */
namespace common;

class YUrl {

    /**
     * 获取当前去除分页符的URL。
     * -- 1、用于分页使用。
     *
     * @param array $params 参数。
     * @return string
     */
    public static function getCurrentTrimPageUrl(array $params = []) {
        $sys_protocal = 'https://';
        if (isset($_SERVER['SERVER_PORT'])) {
            if ($_SERVER['SERVER_PORT'] == '80') {
                $sys_protocal = 'http://';
            } else if ($_SERVER['SERVER_PORT'] == '443') {
                $sys_protocal = 'https://';
            }
        }
        $php_self   = $_SERVER['PHP_SELF'] ? YCore::safe_replace($_SERVER['PHP_SELF']) : self::safe_replace($_SERVER['SCRIPT_NAME']);
        $path_info  = isset($_SERVER['PATH_INFO']) ? YCore::safe_replace($_SERVER['PATH_INFO']) : '';
        $relate_url = isset($_SERVER['REQUEST_URI']) ? YCore::safe_replace($_SERVER['REQUEST_URI']) : $php_self . (isset($_SERVER['QUERY_STRING']) ? '?' . YCore::safe_replace($_SERVER['QUERY_STRING']) : $path_info);
        $pager      = YCore::appconfig('pager');
        $filter_get = [];
        foreach ($_GET as $k => $v) {
            if ($k != $pager) {
                $filter_get[$k] = $v;
            }
        }
        $params = array_merge($filter_get, $params);
        $query = '';
        if ($params) {
            $query .= http_build_query($params);
        }
        $url = $sys_protocal . (isset($_SERVER['HTTP_HOST']) ? $_SERVER['HTTP_HOST'] : '') . $relate_url;
        $url_data = explode('?', $url);
        $filter_url = '';
        if ($params) {
            $filter_url = "{$url_data[0]}?{$query}";
        } else {
            $filter_url = $url_data[0];
        }
        return $filter_url;
    }

    /**
     * 创建一个用户中心的URL。
     *
     * @param string $controller_name 控制器名称。
     * @param string $action_name 操作名称。
     * @param array $params 参数。
     * @return string
     */
    public static function createAccountUrl($controller_name, $action_name, array $params = []) {
        $account_domain_name = self::getDomainName();
        return self::createPageUrl($account_domain_name, 'User', $controller_name, $action_name, $params);
    }

    /**
     * 创建一个管理后台的URL。
     *
     * @param string $controller_name 控制器名称。
     * @param string $action_name 操作名称。
     * @param array $params 参数。
     * @return string
     */
    public static function createBackendUrl($controller_name, $action_name, array $params = []) {
        $backend_domain_name = self::getDomainName();
        return self::createPageUrl($backend_domain_name, 'Backend', $controller_name, $action_name, $params);
    }

    /**
     * 创建一个前端页面的URL。
     *
     * @param string $controller_name 控制器名称。
     * @param string $action_name 操作名称。
     * @param array $params 参数。
     * @return string
     */
    public static function createFrontendUrl($controller_name, $action_name, array $params = []) {
        $frontend_domain_name = self::getDomainName();
        return self::createPageUrl($frontend_domain_name, 'Index', $controller_name, $action_name, $params);
    }

    /**
     * 创建一个页面URL。
     *
     * @param string $domain_name 域名。
     * @param string $module_name 模块名称。
     * @param string $controller_name 控制器名称。
     * @param string $action_name 操作名称。
     * @param array $params 参数。
     * @return string
     */
    public static function createPageUrl($domain_name, $module_name = '', $controller_name = '', $action_name = '', array $params = []) {
        $domain_name = self::getDomainName();
        $domain_name = trim($domain_name, '/');
        $query = '';
        if (strlen($module_name) > 0) {
            $query .= "{$module_name}/";
        }
        if (strlen($controller_name) === 0) {
            $query .= "Index/";
        } else {
            $query .= "{$controller_name}/";
        }
        if (strlen($action_name) === 0) {
            YCore::exception(- 1, 'action_name error');
        }
        $query .= $action_name;
        if ($params) {
            $query .= "?" . http_build_query($params);
        }
        return "{$domain_name}/{$query}";
    }

    /**
     * 获取上传文件的绝对地址。
     *
     * @param string $file_relative_path 相对路径。
     * @return string
     */
    public static function filePath($file_relative_path) {
        if (strlen($file_relative_path) === 0) {
            return '';
        } else {
            $files_url = self::getDomainName();
            ;
            $files_url = trim($files_url, '/');
            $file_relative_path = trim($file_relative_path, '/');
            return $files_url . '/' . $file_relative_path;
        }
    }

    /**
     * 获取当前页面完整URL地址
     */
    public static function get_url() {
        $sys_protocal = isset($_SERVER['SERVER_PORT']) && $_SERVER['SERVER_PORT'] == '443' ? 'https://' : 'http://';
        $php_self     = $_SERVER['PHP_SELF'] ? YCore::safe_replace($_SERVER['PHP_SELF']) : YCore::safe_replace($_SERVER['SCRIPT_NAME']);
        $path_info    = isset($_SERVER['PATH_INFO']) ? YCore::safe_replace($_SERVER['PATH_INFO']) : '';
        $relate_url   = isset($_SERVER['REQUEST_URI']) ? YCore::safe_replace($_SERVER['REQUEST_URI']) : $php_self . (isset($_SERVER['QUERY_STRING']) ? '?' . YCore::safe_replace($_SERVER['QUERY_STRING']) : $path_info);
        return $sys_protocal . (isset($_SERVER['HTTP_HOST']) ? $_SERVER['HTTP_HOST'] : '') . $relate_url;
    }

    /**
     * 获取当前域名。
     *
     * @param boolean $is_full_format 是否完整格式。完整格式是带 http:// 或 https://
     * @return string
     */
    public static function getDomainName($is_full_format = true) {
        $sys_protocal = '';
        if ($is_full_format) {
            $sys_protocal = isset($_SERVER['SERVER_PORT']) && $_SERVER['SERVER_PORT'] == '443' ? 'https://' : 'http://';
        }
        return $sys_protocal . (isset($_SERVER['HTTP_HOST']) ? $_SERVER['HTTP_HOST'] : '');
    }

    /**
     * 获取静态资源URL。
     *
     * @param string $type css、js、image
     * @param string $file_relative_path 资源相对路径。如：/jquery/plugins/cookie.js
     * @return string
     */
    public static function assets($type, $file_relative_path) {
        $statics_url = self::getDomainName();
        $statics_url = trim($statics_url, '/');
        $statics_url = $statics_url . "/statics";
        switch ($type) {
            case 'js' :
                $statics_url .= '/js/';
                break;
            case 'css' :
                $statics_url .= '/css/';
                break;
            case 'image' :
                $statics_url .= '/images/';
                break;
            default :
                $statics_url .= "/{$type}/";
                break;
        }
        $file_relative_path = trim($file_relative_path, '/');
        return $statics_url . $file_relative_path;
    }

}