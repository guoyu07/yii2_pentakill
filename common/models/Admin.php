<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "ms_admin".
 *
 * @property string $admin_id
 * @property string $realname
 * @property string $username
 * @property string $password
 * @property string $salt
 * @property string $mobilephone
 * @property integer $roleid
 * @property string $lastlogintime
 * @property integer $status
 * @property string $created_time
 */
class Admin extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'ms_admin';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['realname', 'username', 'password', 'salt', 'created_time'], 'required'],
            [['roleid', 'lastlogintime', 'status', 'created_time'], 'integer'],
            [['realname', 'username'], 'string', 'max' => 20],
            [['password'], 'string', 'max' => 32],
            [['salt'], 'string', 'max' => 6],
            [['mobilephone'], 'string', 'max' => 11],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'admin_id' => 'Admin ID',
            'realname' => 'Realname',
            'username' => 'Username',
            'password' => 'Password',
            'salt' => 'Salt',
            'mobilephone' => 'Mobilephone',
            'roleid' => 'Roleid',
            'lastlogintime' => 'Lastlogintime',
            'status' => 'Status',
            'created_time' => 'Created Time',
        ];
    }
}
