DROP DATABASE IF EXISTS pentakill;
CREATE DATABASE pentakill DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
use pentakill;


DROP TABLE IF EXISTS `ms_sms_log`;
CREATE TABLE ms_sms_log (
log_id INT(11) UNSIGNED AUTO_INCREMENT COMMENT '日志ID',
op_type TINYINT(1) NOT NULL COMMENT '操作类型：1发送、2验证',
mobilephone CHAR(11) NOT NULL COMMENT '手机号码',
sms_txt CHAR(200) NOT NULL COMMENT '短信内容',
sms_code CHAR(6) NOT NULL DEFAULT '' COMMENT '验证码。如果是非验证码短信，此值为空字符串',
is_destroy TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否验证成功立即销毁。1是、0否',
created_time INT(11) UNSIGNED NOT NULL COMMENT '创建时间',
PRIMARY KEY(log_id),
KEY(mobilephone)
)ENGINE = InnoDB DEFAULT CHARSET = 'UTF8' COMMENT '短信发送/验证日志表';


# 应用日志表
DROP TABLE IF EXISTS ms_log;
CREATE TABLE ms_log(
	log_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
	log_type TINYINT(1) NOT NULL DEFAULT '0' COMMENT '日志类型：参见models\Log常量',
	log_user_id INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '操作用户ID',
	log_time INT(11) UNSIGNED NOT NULL COMMENT '日志产生时间',
	errcode INT(11) NOT NULL DEFAULT '0' COMMENT '错误编号',
	content TEXT COMMENT '日志内容',
	created_time INT(11) UNSIGNED NOT NULL COMMENT '日志创建时间',
	PRIMARY KEY(log_id)
) ENGINE = InnoDB DEFAULT CHARSET UTF8 COMMENT '系统日志表';


# 字典类型表
DROP TABLE IF EXISTS ms_dict_type;
CREATE TABLE ms_dict_type(
	dict_type_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
	type_code CHAR(50) NOT NULL COMMENT '字典类型编码',
    type_name CHAR(50) NOT NULL COMMENT '字典类型名称',
	value_more TINYINT(1) NOT NULL COMMENT '值是否多列：1是、0否 ',
	value_type CHAR(20) NOT NULL COMMENT '字典值类型:',
    description CHAR(200) NOT NULL DEFAULT '' COMMENT '字典类型描述',
    status TINYINT(1) NOT NULL DEFAULT '0' COMMENT '状态：0失效、1有效、2删除',
    created_by INT(11) UNSIGNED NOT NULL COMMENT '类型创建人',
	created_time INT(11) UNSIGNED NOT NULL COMMENT '类型创建时间',
	modified_by INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '类型修改人',
	modified_time INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '类型修改时间',
	PRIMARY KEY(dict_type_id),
	KEY `type_code` (type_code)
) ENGINE = InnoDB DEFAULT CHARSET UTF8 COMMENT '字典类型表';

# 字典数据表
DROP TABLE IF EXISTS ms_dict;
CREATE TABLE ms_dict(
	dict_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
	dict_type_id INT(11) UNSIGNED NOT NULL COMMENT '主键',
	dict_code CHAR(50) NOT NULL COMMENT '字典编码',
    dict_value CHAR(255) NOT NULL DEFAULT '' COMMENT '字典值',
    description CHAR(255) NOT NULL DEFAULT '' COMMENT '字典类型描述',
    listorder SMALLINT(1) NOT NULL DEFAULT '0' COMMENT '排序。小在前',
    status TINYINT(1) NOT NULL DEFAULT '0' COMMENT '状态：0失效、1有效、2删除',
    created_by INT(11) UNSIGNED NOT NULL COMMENT '类型创建人',
	created_time INT(11) UNSIGNED NOT NULL COMMENT '类型创建时间',
	modified_by INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '类型修改人',
	modified_time INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '类型修改时间',
	PRIMARY KEY(dict_id),
	KEY(dict_type_id)
) ENGINE = InnoDB DEFAULT CHARSET UTF8 COMMENT '字典数据表';


# 文件表
# 上传的图片、视频等文件记录在此表中。
# 如果是公开的图片则图片链接是固定的。私有的则图片链接是动态生成的。
DROP TABLE IF EXISTS ms_files;
CREATE TABLE ms_files(
	file_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
	file_name CHAR(50) NOT NULL COMMENT '文件名称',
	file_type TINYINT(1) NOT NULL COMMENT '文件类型：1-图片、2-其他文件',
	file_size INT(11) UNSIGNED NOT NULL COMMENT '文件大小。单位：(byte)',
	file_md5 CHAR(32) NOT NULL COMMENT '文件md5值',
	user_type TINYINT(1) NOT NULL COMMENT '用户类型：1管理员、2普通用户',
	user_id INT(11) UNSIGNED NOT NULL COMMENT '用户ID',
	status TINYINT(1) NOT NULL DEFAULT '0' COMMENT '状态：0失效、1有效、2删除',
	created_time INT(11) UNSIGNED NOT NULL COMMENT '创建时间',
	PRIMARY KEY(file_id)
) ENGINE = InnoDB DEFAULT CHARSET UTF8 COMMENT '文件表';


# 管理员表
DROP TABLE IF EXISTS ms_admin;
CREATE TABLE ms_admin(
	admin_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
	realname CHAR(20) NOT NULL COMMENT '真实姓名',
	username CHAR(20) NOT NULL COMMENT '账号',
	password CHAR(32) NOT NULL COMMENT '密码',
	salt CHAR(6) NOT NULL COMMENT '密码盐',
	mobilephone CHAR(11) NOT NULL DEFAULT '' COMMENT '手机号码',
	roleid SMALLINT(3) NOT NULL DEFAULT '0' COMMENT '角色ID',
	lastlogintime INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '最后登录时间戳',
	status TINYINT(1) NOT NULL DEFAULT '0' COMMENT '状态：0失效、1有效、2删除',
	created_time INT(11) UNSIGNED NOT NULL COMMENT '创建时间',
	PRIMARY KEY(admin_id),
	KEY(username),
	KEY(mobilephone)
) ENGINE = InnoDB DEFAULT CHARSET UTF8 COMMENT '管理员表';
INSERT INTO ms_admin (admin_id, realname, username, password, salt, status, created_time, roleid)
VALUES(1, '超级管理员', 'admin', 'c7935cc8ee50b752345290d8cf136827', 'abcdef', 1, unix_timestamp(now()), 1);


# 管理员登录历史表	
DROP TABLE IF EXISTS ms_admin_login_history;
CREATE TABLE `ms_admin_login_history` (
  id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  admin_id INT(11) UNSIGNED NOT NULL COMMENT '管理员ID',
  browser_type CHAR(10) NOT NULL COMMENT '浏览器类型。tablet平板、phone手机、computer电脑',
  user_agent VARCHAR(200) NOT NULL COMMENT '浏览器UA',
  ip CHAR(15) NOT NULL COMMENT '登录IP',
  address VARCHAR(100) NOT NULL DEFAULT '' COMMENT 'IP对应的地址信息',
  created_time INT(11) UNSIGNED NOT NULL COMMENT '登录时间',
  PRIMARY KEY(id)
) ENGINE=InnoDB DEFAULT CHARSET UTF8 COMMENT '管理员登录历史表';


# 角色表	
DROP TABLE IF EXISTS ms_admin_role;
CREATE TABLE ms_admin_role(
	roleid INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '角色ID',
	rolename CHAR(20) NOT NULL COMMENT '角色名称',
	listorder SMALLINT(3) NOT NULL DEFAULT '0' COMMENT '排序。小在前。',
	description CHAR(255) NOT NULL DEFAULT '' COMMENT '角色说明',
	status TINYINT(1) NOT NULL DEFAULT '0' COMMENT '状态：0失效、1有效、2删除',
	created_time INT(11) UNSIGNED NOT NULL COMMENT '创建时间',
	is_default TINYINT(1) NOT NULL DEFAULT '0' COMMENT '默认角色拥有最高权限。不可删除此默认角色。超级管理员只能属于此角色，其他用户不可分配此角色',
	PRIMARY KEY(roleid)
) ENGINE = InnoDB DEFAULT CHARSET UTF8 COMMENT '角色表';
INSERT INTO ms_admin_role (roleid, rolename, status, is_default, created_time) VALUES(1, '超级管理员', 1, 1, unix_timestamp(now()));


# 角色权限表	
DROP TABLE IF EXISTS ms_admin_role_priv;
CREATE TABLE `ms_admin_role_priv` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `roleid` SMALLINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '角色ID',
  `menu_id` INT(11) UNSIGNED NOT NULL COMMENT '菜单ID',
  PRIMARY KEY(id),
  KEY(roleid)
) ENGINE=InnoDB DEFAULT CHARSET UTF8 COMMENT '角色权限表';

# 找回密码记录表
DROP TABLE IF EXISTS ms_find_pwd;
CREATE TABLE ms_find_pwd(
	id INT(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
	user_id INT(11) UNSIGNED NOT NULL COMMENT '用户ID',
	find_type TINYINT(1) NOT NULL COMMENT '找回密码类型：1手机号找回、2邮箱找回',
	to_account CHAR(50) NOT NULL COMMENT '手机或邮箱或其他',
	code CHAR(6) NOT NULL COMMENT '验证码',
	check_times SMALLINT(3) NOT NULL DEFAULT '0' COMMENT '验证次数',
	is_ok TINYINT(1) NOT NULL DEFAULT '0' COMMENT '最后一次否验证通过标记。0未使用、1已通过验证、2未验证通过',
	ip CHAR(15) NOT NULL COMMENT 'IP地址',
	created_time INT(11) UNSIGNED NOT NULL COMMENT '创建时间',
	modified_time INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '修改时间',
	PRIMARY KEY(id),
	KEY(find_type, to_account)
) ENGINE = InnoDB DEFAULT CHARSET UTF8 COMMENT '找回密码记录表';

# 文章表
DROP TABLE IF EXISTS ms_news;
CREATE TABLE `ms_news` (
	news_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '文章ID、主键',
	cat_id INT(11) UNSIGNED NOT NULL COMMENT '分类ID。对应ms_category.cat_id',
	title CHAR(50) NOT NULL COMMENT '文章标题',
	code CHAR(20) NOT NULL COMMENT '文章编码(只允许字母数字下划线横线)',
	intro CHAR(250) NOT NULL COMMENT '文章简介。也是SEO中的description',
	keywords CHAR(50) NOT NULL DEFAULT '' COMMENT '文章关键词。也是SEO中的keywords',
	image_url CHAR(100) NOT NULL DEFAULT '' COMMENT '文章列表图片',
	source CHAR(20) NOT NULL DEFAULT '' COMMENT '文章来源',
	display TINYINT(1) NOT NULL DEFAULT '0' COMMENT '文章是否显示。1显示、0隐藏',
	status TINYINT(1) NOT NULL DEFAULT '0' COMMENT '文章状态：0无效、1正常、2删除',
	listorder SMALLINT(6) UNSIGNED NOT NULL DEFAULT '0' COMMENT '排序。小到大排序。',
	hits INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '文章访问量',
	created_by INT(11) UNSIGNED NOT NULL COMMENT '创建人',
	created_time INT(11) UNSIGNED NOT NULL COMMENT '创建时间',
	modified_by INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '修改人',
	modified_time INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '修改时间',
	PRIMARY KEY(news_id),
	KEY(created_time),
	KEY(created_by)
) ENGINE=InnoDB DEFAULT CHARSET UTF8 COMMENT '文章表';

# 文章副表
DROP TABLE IF EXISTS ms_news_data;
CREATE TABLE `ms_news_data` (
	news_id INT(11) UNSIGNED NOT NULL COMMENT '文章ID',
	content TEXT COMMENT '文章内容',
	PRIMARY KEY(news_id)
) ENGINE=InnoDB DEFAULT CHARSET UTF8 COMMENT '文章副表';


# 友情链接表
# 通过一个URL来统一跳转这些友情链接。方便统计。
DROP TABLE IF EXISTS ms_link;
CREATE TABLE `ms_link` (
	link_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
	link_name VARCHAR(50) NOT NULL COMMENT '友情链接名称',
	link_url VARCHAR(100) NOT NULL COMMENT '友情链接URL',
	cat_id INT(11) UNSIGNED NOT NULL COMMENT '友情链接分类ID。对应ms_category.cat_id',
	image_url VARCHAR(100) NOT NULL DEFAULT '' COMMENT '友情链接图片',
	display TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否显示。1显示、0隐藏',
	status TINYINT(1) NOT NULL DEFAULT '0' COMMENT '状态：0无效、1正常、2删除',
	listorder SMALLINT(6) UNSIGNED NOT NULL DEFAULT '0' COMMENT '排序。小到大排序。',
	hits INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'URL点击量',
	created_by INT(11) UNSIGNED NOT NULL COMMENT '创建人',
	created_time INT(11) UNSIGNED NOT NULL COMMENT '创建时间',
	modified_by INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '修改人',
	modified_time INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '修改时间',
	PRIMARY KEY(link_id)
) ENGINE=InnoDB DEFAULT CHARSET UTF8 COMMENT '友情链接表';


# 广告位置接表
DROP TABLE IF EXISTS ms_ad_position;
CREATE TABLE `ms_ad_position` (
	pos_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
	pos_name VARCHAR(50) NOT NULL COMMENT '广告位置名称',
	pos_code VARCHAR(50) NOT NULL COMMENT '广告位置编码。通过编码来读取广告数据',
	pos_ad_count SMALLINT(5) NOT NULL COMMENT '该广告位置显示可展示广告的数量',
	status TINYINT(1) NOT NULL COMMENT '状态：0无效、1正常、2删除',
	created_by INT(11) UNSIGNED NOT NULL COMMENT '创建人',
	created_time INT(11) UNSIGNED NOT NULL COMMENT '创建时间',
	modified_by INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '修改人',
	modified_time INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '修改时间',
	PRIMARY KEY(pos_id)
) ENGINE=InnoDB DEFAULT CHARSET UTF8 COMMENT '广告位置接表';

# 广告表
DROP TABLE IF EXISTS ms_ad;
CREATE TABLE `ms_ad` (
	ad_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
	ad_name VARCHAR(50) NOT NULL COMMENT '广告名称',
	pos_id INT(11) UNSIGNED NOT NULL COMMENT '广告位置。对应ms_ad_postion.pos_id',
	ad_image_url VARCHAR(100) NOT NULL COMMENT '广告图片',
	ad_url VARCHAR(100) NOT NULL COMMENT '广告图片URL跳转地址',
	start_time INT(11) UNSIGNED NOT NULL COMMENT '广告生效时间',
	end_time INT(11) UNSIGNED NOT NULL COMMENT '广告失效时间',
	display TINYINT(1) NOT NULL DEFAULT '1' COMMENT '显示状态：1显示、0隐藏',
	status TINYINT(1) NOT NULL COMMENT '状态：0无效、1正常、2删除',
	listorder SMALLINT(6) UNSIGNED NOT NULL DEFAULT '0' COMMENT '排序。小到大排序。',
	remark VARCHAR(255) NOT NULL DEFAULT '' COMMENT '备注',
	created_by INT(11) UNSIGNED NOT NULL COMMENT '创建人',
	created_time INT(11) UNSIGNED NOT NULL COMMENT '创建时间',
	modified_by INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '修改人',
	modified_time INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '修改时间',
	PRIMARY KEY(ad_id)
) ENGINE=InnoDB DEFAULT CHARSET UTF8 COMMENT '广告表';


# 分类表
# 所有父分类ID为0的分类，都有一个共同的虚拟顶级父类ID为0。
DROP TABLE IF EXISTS `ms_category`;
CREATE TABLE ms_category(
	cat_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分类ID',
	cat_name VARCHAR(50) NOT NULL COMMENT '分类名称',
	cat_type SMALLINT(3) NOT NULL COMMENT '分类类型。见category_type_list字典。',
	parentid INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '父分类ID',
	lv SMALLINT(3) NOT NULL COMMENT '菜单层级',
	cat_code VARCHAR(50) NOT NULL COMMENT '分类code编',
	is_out_url TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否外部链接：1是、0否',
	out_url VARCHAR(255) NOT NULL DEFAULT '' COMMENT '外部链接地址',
	display TINYINT(1) NOT NULL DEFAULT '0' COMMENT '显示状态：1是、0否',
	status TINYINT(1) NOT NULL DEFAULT '0' COMMENT '状态：0无效、1正常、2删除',
	listorder SMALLINT(5) NOT NULL DEFAULT '0' COMMENT '排序值。小到大排列。',
	modified_by INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '修改人',
	modified_time INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '修改时间戳',
	created_time INT(11) UNSIGNED NOT NULL COMMENT '创建时间戳',
	created_by INT(11) UNSIGNED NOT NULL COMMENT '管理员账号ID',
	PRIMARY KEY(cat_id),
	KEY(cat_code)
) ENGINE = InnoDB DEFAULT CHARSET UTF8 COMMENT '分类表';


# 后台菜单表
DROP TABLE IF EXISTS ms_menu;
CREATE TABLE `ms_menu` (
  `menu_id` SMALLINT(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` CHAR(40) NOT NULL DEFAULT '',
  `parentid` SMALLINT(6) NOT NULL DEFAULT '0',
  `m` CHAR(50) NOT NULL DEFAULT '',
  `c` CHAR(50) NOT NULL DEFAULT '',
  `a` CHAR(50) NOT NULL DEFAULT '',
  `data` CHAR(255) NOT NULL DEFAULT '',
  `listorder` SMALLINT(6) UNSIGNED NOT NULL DEFAULT '0',
  `display` ENUM('1','0') NOT NULL DEFAULT '1',
  PRIMARY KEY (`menu_id`),
  KEY `listorder` (`listorder`),
  KEY `parentid` (`parentid`),
  KEY `module` (`m`,`c`,`a`)
) ENGINE=InnoDB DEFAULT CHARSET UTF8 COMMENT '后台菜单表';


INSERT INTO `ms_menu` (`menu_id`, `name`, `parentid`, `m`, `c`, `a`, `data`, `listorder`, `display`)
VALUES

(1000, '常用功能', 0,'','','','',0,'1'),
(1001, '常用功能', 1000,'','','','',0,'1'),
(1002, '修改密码', 1001, 'Index','Admin','editPwd','',0,'1'),
(1003, '登录历史', 1001, 'Index','Admin','loginHistory','',0,'1'),
(1004, '管理后台首页', 1001, 'Index','Index','Index','',0,'0'),
(1005, '管理后台Ajax获取菜单', 1001, 'Index','Index','leftMenu','',0,'0'),
(1006, '管理后台右侧默认页', 1001, 'Index','Index','right','',0,'0'),
(1007, '管理后台面包屑', 1001, 'Index','Index','arrow','',0,'0'),
(1008, '文件上传', '1001', 'Index', 'Index', 'upload', '', '0', '0'),
(1009, '生成首页', '1001', 'Index', 'Index', 'createHomePage', '', '0', '1'),

(2000, '系统设置',0,'','','','',0,'1'),
(2001, '系统配置',2000,'','','','',0,'1'),
(2002, '字典管理',2001,'Index','Dict','dict-list','',0,'1'),
(2003, '添加字典类型',2001,'Index','Dict','dict-type-add','',0,'0'),
(2004, '编辑字典类型',2001,'Index','Dict','dict-type-edit','',0,'0'),
(2005, '删除字典类型',2001,'Index','Dict','dict-type-delete','',0,'0'),
(2006, '字典列表',2001,'Index','Dict','dict-list','',0,'0'),
(2007, '删除字典',2001,'Index','Dict','dict-delete','',0,'0'),
(2008, '添加字典',2001,'Index','Dict','dict-add','',0,'0'),
(2009, '更新字典',2001,'Index','Dict','dict-edit','',0,'0'),
(2010, '字典类型排序',2001,'Index','Dict','sortType','',0,'0'),
(2011, '字典排序',2001,'Index','Dict','sortDict','',0,'0'),
(2012, '字典缓存清除',2001,'Index','Dict','ClearCache','',0,'0'),
(2019, '菜单列表', 2001, 'Index','Menu','index','',0,'1'),
(2020, '添加菜单', 2001, 'Index','Menu','add','',0,'0'),
(2021, '编辑菜单', 2001, 'Index','Menu','edit','',0,'0'),
(2022, '删除菜单', 2001, 'Index','Menu','delete','',0,'0'),
(2023, '菜单排序', 2001, 'Index','Menu','sort','',0,'0'),

(2400, '地区管理', 2000, 'Index','District','','',0,'1'),
(2401, '添加地区', 2400, 'Index','District','add','',0,'0'),
(2402, '编辑地区', 2400, 'Index','District','edit','',0,'0'),
(2403, '删除地区', 2400, 'Index','District','delete','',0,'0'),
(2404, '地区排序', 2400, 'Index','District','sort','',0,'0'),
(2405, '地区列表', 2400,'Index','District','list','',0,'1'),
(2406, '创建地区JSON文件', 2400,'Index','District','create-json-file','',0,'0'),

(2500, '日志管理', 2000,'Index','Log','','',0,'1'),
(2501, '日志查看', 2500,'Index','Log','index','',0,'1'),
(2502, '日志下载', 2500,'Index','Log','download','',0,'0'),
(2503, '日志清空', 2500,'Index','Log','empty','',0,'0'),

(2700, '文件管理', 2000, 'Index','File','','',0,'1'),
(2701, '文件列表', 2700, 'Index','File','index','',0,'1'),
(2702, '删除文件', 2700, 'Index','File','delete','',0,'0'),
(2703, '删除文件', 2700, 'Index','File','download','',0,'0'),


(3000, '权限管理',0,'','','','',0,'1'),

(3001, '管理员管理', 3000, 'Index','Admin','','',0,'1'),
(3002, '管理员列表', 3001, 'Index','Admin','index','',0,'1'),
(3003, '添加管理员', 3002, 'Index','Admin','add','',0,'0'),
(3004, '更新管理员', 3003, 'Index','Admin','edit','',0,'0'),
(3005, '删除管理员', 3004, 'Index','Admin','delete','',0,'0'),

(3100, '角色管理', 3000,'Index','Role','','',0,'1'),
(3101, '角色列表', 3100,'Index','Role','list','',0,'1'),
(3102, '添加角色', 3100,'Index','Role','add','',0,'0'),
(3103, '更新角色', 3100,'Index','Role','edit','',0,'0'),
(3104, '删除角色', 3100,'Index','Role','delete','',0,'0'),
(3105, '角色赋权', 3100,'Index','Role','set-permission','',0,'0'),


(4000, '内容管理',0,'','','','',0,'1'),

(4001, '分类管理', 4000, 'Index','Category','','',0,'1'),
(4002, '分类列表', 4001, 'Index','Category','list','',0,'1'),
(4003, '添加分类', 4001, 'Index','Category','add','',0,'0'),
(4004, '更新分类', 4001, 'Index','Category','edit','',0,'0'),
(4005, '删除分类', 4001, 'Index','Category','delete','',0,'0'),
(4006, '分类排序', 4001, 'Index','Category','sort','',0,'0'),

(4100, '文章管理', 4000, 'Index','News','','',0,'1'),
(4101, '文章列表', 4100, 'Index','News','list','',0,'1'),
(4102, '添加文章', 4100, 'Index','News','add','',0,'0'),
(4103, '更新文章', 4100, 'Index','News','edit','',0,'0'),
(4104, '删除文章', 4100, 'Index','News','delete','',0,'0'),
(4105, '文章排序', 4100, 'Index','News','sort','',0,'0'),

(4200, '友情链接', 4000, 'Index','Link','','',0,'1'),
(4201, '友情链接列表', 4200,'Index','Link','list','',0,'1'),
(4202, '添加友情链接', 4200,'Index','Link','add','',0,'0'),
(4203, '更新友情链接', 4200,'Index','Link','edit','',0,'0'),
(4204, '删除友情链接', 4200,'Index','Link','delete','',0,'0'),
(4205, '友情链接排序', 4200,'Index','Link','sort','',0,'0'),

(4300, '广告管理', 4000,'Index','Ad','','',0,'1'),
(4301, '广告位置列表',4300,'Index','Ad','position-list','',0,'1'),
(4302, '添加广告位置',4300,'Index','Ad','position-add','',0,'0'),
(4303, '更新广告位置',4300,'Index','Ad','position-edit','',0,'0'),
(4304, '删除广告位置',4300,'Index','Ad','position-delete','',0,'0'),
(4305, '广告列表',4300,'Index','Ad','index','',0,'0'),
(4306, '添加广告',4300,'Index','Ad','add','',0,'0'),
(4307, '更新广告',4300,'Index','Ad','edit','',0,'0'),
(4308, '删除广告',4300,'Index','Ad','delete','',0,'0'),
(4309, '广告排序',4300,'Index','Ad','sort','',0,'0');
