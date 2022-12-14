ckEditorConfigs = {
    height: 300,
    // skin: 'bootstrapck',
    startupFocus: true,
    // bodyClass: 'CKEditor',
    // language: 'en',
    toolbar: [
        {name: 'document', items: [ 'Source', '-', /*'Save', 'NewPage', 'ExportPdf', 'Preview', 'Print', '-',*/ 'Templates' ]},
        {name: 'clipboard', items: ['SelectAll', 'Cut', 'Copy', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo']},
        {name: 'styles', items: [/*'Styles', */'Format', 'Font', 'FontSize']},
        {name: 'colors', items: ['TextColor', 'BGColor']},
        {name: 'align', items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock']},
        '/',
        {name: 'basicstyles', items: ['Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'CopyFormatting', 'RemoveFormat']},
        {name: 'links', items: ['Link', 'Unlink'/*, 'Anchor'*/]},
        {name: 'paragraph', items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote'/*, 'CreateDiv', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'BidiLtr', 'BidiRtl', 'Language'*/ ]},
        {name: 'insert', items: ['Image', /*'Flash',*/ 'Table', /*'HorizontalRule',*/ 'Smiley', 'SpecialChar', /*'PageBreak',*/ 'Iframe', 'Youtube', 'EmojiPanel']},
        {name: 'tools', items: ['Maximize', 'ShowBlocks']},
        // {name: 'editing', items: ['Find', 'Replace', '-', 'SelectAll', '-', 'Scayt' ]},
        // {name: 'forms', items: [ 'Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField' ] },
    ],
    filebrowserUploadUrl: '/files/upload/ck?type=Files',
    filebrowserImageUploadUrl: '/files/upload/ck?type=Images',
    filebrowserUploadMethod: 'xhr',

    removePlugins: 'cloudservices,easyimage,image,exportpdf',
    extraPlugins: 'youtube, emoji'
    // extraPlugins: 'print,format,font,colorbutton,justify,uploadimage',
    // extraAllowedContent: 'h3{clear};h2{line-height};h2 h3{margin-left,margin-top}',
    // removeDialogTabs: 'image:advanced;link:advanced'
}
