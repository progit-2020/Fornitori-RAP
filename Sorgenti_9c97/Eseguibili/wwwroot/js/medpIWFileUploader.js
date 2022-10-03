var medpIwFu = {};
medpIwFu.MEdpFileUploader = function(options){
	this._options = {};
	this._options.id = options.id;
	this._options.caption = options.caption;
	this._options.css = options.css;
	this._options.htmlName = options.htmlName;
	this._options.template = options.template;
	this._options.enabled = options.enabled; // ridondante
	this._options.visible = options.visible; // ridondante
	this._options.msg = {};
	this._options.msg.nessunFile = options.msgNessunFile;
	this._options.iwFileUploaderObj = window[this._options.htmlName.toUpperCase() + "_Obj"];
	this.creaPulsante = function(){
		var containerDivFileUploader = $("#" + this._options.htmlName);
		var divFileUploader = containerDivFileUploader.children(".IWFileUploader");
		var pulsante = this._options.template.replace("{classiCss}",this._options.css)
		                                     .replace("{captionPulsante}",this._options.caption)
											 .replace("{id}",this._options.id);
		divFileUploader.after(pulsante);
		this.impostaEnabled(this._options.enabled);	
		this.impostaVisible(this._options.visible);
	};
	this.avviaUpload = function(){		
		var arrayFileCorrenti = this._options.iwFileUploaderObj._storedFileIds;		
		if (arrayFileCorrenti.length > 0)
			IW.FileUploader(this._options.htmlName).startUpload();
		else
			mostraDialogErrore(this._options.msg.nessunFile);
	};
    this.impostaEnabled = function(enabled){
		// Questo metodo viene richiamato anche dal server
        this._options.enabled = enabled;		
		$("#" + this._options.id).prop("disabled",!this._options.enabled);		
	};
	this.impostaVisible = function(visible){
		this._options.visible = visible;
		visible ? $("#" + this._options.id).show() : $("#" + this._options.id).hide();
	}
	this.creaPulsante();
}