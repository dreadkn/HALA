sunEditorConfig = {
    mode: "classic",
    height: 400,
    charCounter: true,
    tabDisable: false,
    linkTargetNewWindow: true,
    linkRel: [
        "author",
        "external",
        "help",
        "license",
        "next",
        "follow",
        "nofollow",
        "noreferrer",
        "noopener",
        "prev",
        "search",
        "tag"
    ],
    linkRelDefault: {
        "default": "nofollow",
        "check_new_window": "noreferrer noopener",
        "check_bookmark": "bookmark"
    },
    buttonList: [
        ["undo", "redo"],
        ["font", "fontSize", "formatBlock","fontColor","hiliteColor","textStyle"],
        ["paragraphStyle", "blockquote", "bold", "underline", "italic", "strike"],
        ["subscript", "superscript"],
        ["removeFormat", "outdent", "indent", "align", "horizontalRule", "list", "lineHeight", "table"],
        ["link", "image", "fullScreen", "showBlocks", "codeView", "preview", "print"]
    ],
    imageUploadUrl: '/files/upload/sun?type=Images',
    lang: SUNEDITOR_LANG.ko,

}