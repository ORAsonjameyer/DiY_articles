create index wksp_mlegenai.sm_reactions_i1 on
    wksp_mlegenai.sm_reactions (
        post_id
    );


-- sqlcl_snapshot {"hash":"048b75443668bb28349820541d2b8819a2f39556","type":"INDEX","name":"SM_REACTIONS_I1","schemaName":"WKSP_MLEGENAI","sxml":"\n  <INDEX xmlns=\"http://xmlns.oracle.com/ku\" version=\"1.0\">\n   <SCHEMA>WKSP_MLEGENAI</SCHEMA>\n   <NAME>SM_REACTIONS_I1</NAME>\n   <TABLE_INDEX>\n      <ON_TABLE>\n         <SCHEMA>WKSP_MLEGENAI</SCHEMA>\n         <NAME>SM_REACTIONS</NAME>\n      </ON_TABLE>\n      <COL_LIST>\n         <COL_LIST_ITEM>\n            <NAME>POST_ID</NAME>\n         </COL_LIST_ITEM>\n      </COL_LIST>\n      \n   </TABLE_INDEX>\n</INDEX>"}