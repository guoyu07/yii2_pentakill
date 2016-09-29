<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "ms_admin_role_priv".
 *
 * @property string $id
 * @property integer $roleid
 * @property string $menu_id
 */
class AdminRolePriv extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'ms_admin_role_priv';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['roleid', 'menu_id'], 'integer'],
            [['menu_id'], 'required'],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'roleid' => 'Roleid',
            'menu_id' => 'Menu ID',
        ];
    }
}
