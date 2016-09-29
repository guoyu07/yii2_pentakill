<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "ms_menu".
 *
 * @property integer $menu_id
 * @property string $name
 * @property integer $parentid
 * @property string $m
 * @property string $c
 * @property string $a
 * @property string $data
 * @property integer $listorder
 * @property string $display
 */
class Menu extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'ms_menu';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['parentid', 'listorder'], 'integer'],
            [['display'], 'string'],
            [['name'], 'string', 'max' => 40],
            [['m', 'c', 'a'], 'string', 'max' => 50],
            [['data'], 'string', 'max' => 255],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'menu_id' => 'Menu ID',
            'name' => 'Name',
            'parentid' => 'Parentid',
            'm' => 'M',
            'c' => 'C',
            'a' => 'A',
            'data' => 'Data',
            'listorder' => 'Listorder',
            'display' => 'Display',
        ];
    }
}
