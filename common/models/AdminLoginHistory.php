<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "ms_admin_login_history".
 *
 * @property string $id
 * @property string $admin_id
 * @property string $browser_type
 * @property string $user_agent
 * @property string $ip
 * @property string $address
 * @property string $created_time
 */
class AdminLoginHistory extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'ms_admin_login_history';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['admin_id', 'browser_type', 'user_agent', 'ip', 'created_time'], 'required'],
            [['admin_id', 'created_time'], 'integer'],
            [['browser_type'], 'string', 'max' => 10],
            [['user_agent'], 'string', 'max' => 200],
            [['ip'], 'string', 'max' => 15],
            [['address'], 'string', 'max' => 100],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'admin_id' => 'Admin ID',
            'browser_type' => 'Browser Type',
            'user_agent' => 'User Agent',
            'ip' => 'Ip',
            'address' => 'Address',
            'created_time' => 'Created Time',
        ];
    }
}
