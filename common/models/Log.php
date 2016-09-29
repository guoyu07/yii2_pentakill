<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "ms_log".
 *
 * @property string $log_id
 * @property integer $log_type
 * @property string $log_user_id
 * @property string $log_time
 * @property integer $errcode
 * @property string $content
 * @property string $created_time
 */
class Log extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'ms_log';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['log_type', 'log_user_id', 'log_time', 'errcode', 'created_time'], 'integer'],
            [['log_time', 'created_time'], 'required'],
            [['content'], 'string'],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'log_id' => 'Log ID',
            'log_type' => 'Log Type',
            'log_user_id' => 'Log User ID',
            'log_time' => 'Log Time',
            'errcode' => 'Errcode',
            'content' => 'Content',
            'created_time' => 'Created Time',
        ];
    }
}
