<?php
/**
 * 短信业务封装。
 * -- 1、支持主流平台的短信接口（luosima.com、聚合、阿里大鱼）
 * -- 2、支持短信验证码验证
 * -- 3、支持每号码每天最大发送数量设定（在发送渠道允许的最大值下设定）。
 * -- 4、支持每号码每分钟允许发送的数量。
 * -- 5、支持每IP允许发送的数量。
 * -- 6、当触发上述警报之后，可以通过人工干预解除。
 * -- 7、余额不足或数量超发送平台限制能根据错误显示警报关抄送给系统管理员。
 *
 * @author winerQin
 * @date 2016-09-35
 */

namespace common\services;

class SmsService extends BaseService {

}