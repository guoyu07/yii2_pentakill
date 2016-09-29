<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "ms_dict".
 *
 * @property string $dict_id
 * @property string $dict_type_id
 * @property string $dict_code
 * @property string $dict_value
 * @property string $description
 * @property integer $listorder
 * @property integer $status
 * @property string $created_by
 * @property string $created_time
 * @property string $modified_by
 * @property string $modified_time
 */
class Dict extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'ms_dict';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['dict_type_id', 'dict_code', 'created_by', 'created_time'], 'required'],
            [['dict_type_id', 'listorder', 'status', 'created_by', 'created_time', 'modified_by', 'modified_time'], 'integer'],
            [['dict_code'], 'string', 'max' => 50],
            [['dict_value', 'description'], 'string', 'max' => 255],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'dict_id' => 'Dict ID',
            'dict_type_id' => 'Dict Type ID',
            'dict_code' => 'Dict Code',
            'dict_value' => 'Dict Value',
            'description' => 'Description',
            'listorder' => 'Listorder',
            'status' => 'Status',
            'created_by' => 'Created By',
            'created_time' => 'Created Time',
            'modified_by' => 'Modified By',
            'modified_time' => 'Modified Time',
        ];
    }
}
