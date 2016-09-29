<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "ms_dict_type".
 *
 * @property string $dict_type_id
 * @property string $type_code
 * @property string $type_name
 * @property integer $value_more
 * @property string $value_type
 * @property string $description
 * @property integer $status
 * @property string $created_by
 * @property string $created_time
 * @property string $modified_by
 * @property string $modified_time
 */
class DictType extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'ms_dict_type';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['type_code', 'type_name', 'value_more', 'value_type', 'created_by', 'created_time'], 'required'],
            [['value_more', 'status', 'created_by', 'created_time', 'modified_by', 'modified_time'], 'integer'],
            [['type_code', 'type_name'], 'string', 'max' => 50],
            [['value_type'], 'string', 'max' => 20],
            [['description'], 'string', 'max' => 200],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'dict_type_id' => 'Dict Type ID',
            'type_code' => 'Type Code',
            'type_name' => 'Type Name',
            'value_more' => 'Value More',
            'value_type' => 'Value Type',
            'description' => 'Description',
            'status' => 'Status',
            'created_by' => 'Created By',
            'created_time' => 'Created Time',
            'modified_by' => 'Modified By',
            'modified_time' => 'Modified Time',
        ];
    }
}
