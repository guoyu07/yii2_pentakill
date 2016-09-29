<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "ms_files".
 *
 * @property string $file_id
 * @property string $file_name
 * @property integer $file_type
 * @property string $file_size
 * @property string $file_md5
 * @property integer $user_type
 * @property string $user_id
 * @property integer $status
 * @property string $created_time
 */
class Files extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'ms_files';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['file_name', 'file_type', 'file_size', 'file_md5', 'user_type', 'user_id', 'created_time'], 'required'],
            [['file_type', 'file_size', 'user_type', 'user_id', 'status', 'created_time'], 'integer'],
            [['file_name'], 'string', 'max' => 50],
            [['file_md5'], 'string', 'max' => 32],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'file_id' => 'File ID',
            'file_name' => 'File Name',
            'file_type' => 'File Type',
            'file_size' => 'File Size',
            'file_md5' => 'File Md5',
            'user_type' => 'User Type',
            'user_id' => 'User ID',
            'status' => 'Status',
            'created_time' => 'Created Time',
        ];
    }
}
