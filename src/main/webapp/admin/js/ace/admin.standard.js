jQuery.standard = {
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
					"sAjaxSource" : $.ace.getContextPath() + "/admin/standard/list",
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
						"mDataProp" : ""
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
								return" <button class=\"btn2 btn-info\" onclick=\"$.standard.showEdit("+oObj.aData.id+")\"><i class=\"icon-edit\"></i> 设置收费标准</button> ";
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
	        			url : $.ace.getContextPath() + "/admin/standard/delete/"+id,
	        			dataType : "json",
	        			success : function(json) {
	        				if(json.state=='success'){
	        					noty({"text":""+ json.msg +"","layout":"top","type":"success","timeout":"2000"});
	        					$.standard.initSearchDataTable();
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
			$("#year").val($("#_year").val());
			$.ajax({
    			type : "get",
    			url : $.ace.getContextPath() + "/admin/standard/get/"+id,
    			dataType : "json",
    			success : function(json) {
    				if(json.state=='success'){
    					$("#name").val(json.object.name);
    					$("#school").val(json.object.school);
    					$("#unit").val(json.object.unit);
    					$("#cash").val(json.object.cash);
    					$("#standarddate").val(json.object.standarddate);
    					$("#remark").val(json.object.remark);
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