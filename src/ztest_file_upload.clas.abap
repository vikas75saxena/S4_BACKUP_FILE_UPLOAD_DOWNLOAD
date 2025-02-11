CLASS ztest_file_upload DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  TYPES: begin of ty_podata,
          PurchaseOrder type ebeln,
          Supplier type lifnr,
          PurchasingOrganization type zekorg,
        end of ty_podata,
        tty_podata TYPE STANDARD TABLE OF ty_podata WITH key PurchaseOrder,
        ty_filepath type c LENGTH 40.
  Methods: select_data RETURNING VALUE(rt_data) TYPE tty_podata,
           write_data_to_file.
  PROTECTED SECTION.
  PRIVATE SECTION.
   DATA: mt_podata type tty_podata,
         mv_file type ty_filepath VALUE '/tmp/vikas/podata.txt'.
ENDCLASS.



CLASS ztest_file_upload IMPLEMENTATION.
method select_data.
select PurchaseOrder,
       Supplier,
       PurchasingOrganization
      from I_PURCHASEORDERAPI01 into table @mt_podata up to 10 rows.
endmethod.
method write_data_to_file.
  data(lo_file_utility) = NEW ztest_file_upload_classic(  ).
  lo_file_utility->open_file( mv_file ).
  lo_file_utility->write_data_to_file( mt_podata ).
endmethod.
ENDCLASS.
