jQuery.standardview = {
		userDataTable:null,
		initSearchDataTable : function() {
			if (this.userDataTable == null) {
				this.userDataTable = $('#dt_table_view').dataTable({
					"sDom" : "<'row-fluid'r>t",
					"sPaginationType" : "bootstrap",
					"oLanguage" : {
						"sLengthMenu" : "每页显示 _MENU_ 条记录",
						"sZeroRecords" : "抱歉， 暂时没有记录",
						"sInfo" : "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
						"sSearch" : "",
						"sInfoEmpty" : "没有数据",
						"sInfoFiltered" : "(从 _MAX_ 条数据中检索)",
						"oPaginate" : {
							"sFirst" : "首页",
							"sPrevious" : "前一页",
							"sNext" : "后一页",
							"sLast" : "尾页"
						}
					},
					"bAutoWidth" : false,
					"iDisplayLength" : 10,
					"aLengthMenu" : [ 5, 10, 25, 50],
					"bServerSide" : true,
					"sServerMethod" : "POST",
					"bProcessing" : true,
					"bSort" : false,
					"sAjaxSource" : $.ace.getContextPath() + "/admin/standardview/list",
					"fnDrawCallback" : function(oSettings) {
						$('[rel="popover"],[data-rel="popover"]').popover();
					},
					"fnServerData" : function(sSource, aoData, fnCallback) {
						var year = $("#_year").val();
						var major = $("#_major").val();
						var grade = $("#_grade").val();
						if (!!year) {
							aoData.push({
								"name" : "year",
								"value" : year
							});
						}
						if (!!major) {
							aoData.push({
								"name" : "major",
								"value" : major
							});
						}
						if (!!grade) {
							aoData.push({
								"name" : "grade",
								"value" : grade
							});
						}
						$.ajax({
							"dataType" : 'json',
							"type" : "POST",
							"url" : sSource,
							"data" : aoData,
							"success" : function(data){
								fnCallback(data);
							}
						});
					},
					"aoColumns" : [{
						"mDataProp" : "year"
					}, {
						"mDataProp" : "major.name"
					},{
						"mDataProp" : "name"
					},{
						"mDataProp" : "toalfee"
					},{
						"mDataProp" : "state"
					},{
						"mDataProp" : "standard.id"
					}],
					"aoColumnDefs" : [
						{
							'aTargets' : [3],
							'fnRender' : function(oObj, sVal) {
								if(sVal!=null)
								return"  <span class='badge badge-success'>"+sVal+"</span>";
							}
						},
						
						{
							'aTargets' : [4],
							'fnRender' : function(oObj, sVal) {
								if(sVal=='未设置')
									return"  <span class='label label-important'>"+sVal+"</span>";
								else
									return"  <span class='label label-info'>"+sVal+"</span>";
								
							}
						},
						{
							'aTargets' : [5],
							'fnRender' : function(oObj, sVal) {
								if(sVal!=null)
								return" <button class=\"btn2 btn-info\" onclick=\"$.standardview.showEdit("+oObj.aData.standard.id+")\"><i class=\"icon-edit\"></i>查看详情</button> ";
							}
						},
					 {
						'aTargets' : [ '_all' ],
						'bSortable' : false,
						'sClass' : 'center'
					}]

				});
			} else {
				var oSettings = this.userDataTable.fnSettings();
				oSettings._iDisplayStart = 0;
				this.userDataTable.fnDraw(oSettings);
			}

		},
		deleteUser :function(id){
			bootbox.confirm( "是否确认删除？", function (result) {
	            if(result){
	            	$.ajax({
	        			type : "get",
	        			url : $.ace.getContextPath() + "/admin/standardview/delete/"+id,
	        			dataType : "json",
	        			success : function(json) {
	        				if(json.state=='success'){
	        					noty({"text":""+ json.msg +"","layout":"top","type":"success","timeout":"2000"});
	        					$.standardview.initSearchDataTable();
	        				}else{
	        					noty({"text":""+ json.resultMap.msg +"","layout":"top","type":"warning"});
	        				}
	        			}
	        		});
	            }
	        });
		},
		showUserAddModal: function(id){
			$("#id").val(id);
			$('#_modal').modal({
			});
			$("#_modal").modal('show');
		},
		showEdit: function (id){
			$("#id").val(id);
			$.ajax({
    			type : "get",
    			url : $.ace.getContextPath() + "/admin/standardview/get/"+id,
    			dataType : "json",
    			success : function(json) {
    				if(json.state=='success'){
    					for(i=0;i<json.object.items.length;i++){
    						$("#_form").append("<div class='control-group'> "+
									   "<label  class='control-label'>"+json.object.items[i].category.name+"：</label>"+
										json.object.items[i].fee+
								   " </div>");
    						
    					}
    				}else{
    					noty({"text":""+ json.msg +"","layout":"top","type":"warning"});
    				}
    			}
    		});
			$("#_modal").modal('show');
		},
		
		saveUser: function(id){
			$.ajax({
    			type : "post",
    			url : $.ace.getContextPath() + "/admin/standard/save",
    			data:$("form").serialize(),
    			dataType : "json",
    			success : function(json) {
    				if(json.state=='success'){
    					$("#_modal").modal('hide');
    					noty({"text":""+ json.msg +"","layout":"top","type":"success","timeout":"2000"});
    					$.standard.initSearchDataTable();
    				}else{
    					noty({"text":""+ json.msg +"","layout":"top","type":"warning"});
    				}
    			}
    		});
		}
		
};