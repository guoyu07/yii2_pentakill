<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "ms_sms_log".
 *
 * @property string $log_id
 * @property integer $op_type
 * @property string $mobilephone
 * @property string $sms_txt
 * @property string $sms_code
 * @property integer $is_destroy
 * @property string $created_time
 */
class SmsLog extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'ms_sms_log';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['op_type', 'mobilephone', 'sms_txt', 'created_time'], 'required'],
            [['op_type', 'is_destroy', 'created_time'], 'integer'],
            [['mobilephone'], 'string', 'max' => 11],
            [['sms_txt'], 'string', 'max' => 200],
            [['sms_code'], 'string', 'max' => 6],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'log_id' => 'Log ID',
            'op_type' => 'Op Type',
            'mobilephone' => 'Mobilephone',
            'sms_txt' => 'Sms Txt',
            'sms_code' => 'Sms Code',
            'is_destroy' => 'Is Destroy',
            'created_time' => 'Created Time',
        ];
    }
}
