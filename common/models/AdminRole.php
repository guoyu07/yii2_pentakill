<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "ms_admin_role".
 *
 * @property string $roleid
 * @property string $rolename
 * @property integer $listorder
 * @property string $description
 * @property integer $status
 * @property string $created_time
 * @property integer $is_default
 */
class AdminRole extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'ms_admin_role';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['rolename', 'created_time'], 'required'],
            [['listorder', 'status', 'created_time', 'is_default'], 'integer'],
            [['rolename'], 'string', 'max' => 20],
            [['description'], 'string', 'max' => 255],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'roleid' => 'Roleid',
            'rolename' => 'Rolename',
            'listorder' => 'Listorder',
            'description' => 'Description',
            'status' => 'Status',
            'created_time' => 'Created Time',
            'is_default' => 'Is Default',
        ];
    }
}
