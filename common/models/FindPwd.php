<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "ms_find_pwd".
 *
 * @property integer $id
 * @property string $user_id
 * @property integer $find_type
 * @property string $to_account
 * @property string $code
 * @property integer $check_times
 * @property integer $is_ok
 * @property string $ip
 * @property string $created_time
 * @property string $modified_time
 */
class FindPwd extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'ms_find_pwd';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['user_id', 'find_type', 'to_account', 'code', 'ip', 'created_time'], 'required'],
            [['user_id', 'find_type', 'check_times', 'is_ok', 'created_time', 'modified_time'], 'integer'],
            [['to_account'], 'string', 'max' => 50],
            [['code'], 'string', 'max' => 6],
            [['ip'], 'string', 'max' => 15],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'user_id' => 'User ID',
            'find_type' => 'Find Type',
            'to_account' => 'To Account',
            'code' => 'Code',
            'check_times' => 'Check Times',
            'is_ok' => 'Is Ok',
            'ip' => 'Ip',
            'created_time' => 'Created Time',
            'modified_time' => 'Modified Time',
        ];
    }
}
