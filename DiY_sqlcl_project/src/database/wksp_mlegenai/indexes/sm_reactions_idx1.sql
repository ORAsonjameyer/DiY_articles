create unique index wksp_mlegenai.sm_reactions_idx1 on
    wksp_mlegenai.sm_reactions (
        post_id,
        created_by
    );


-- sqlcl_snapshot {"hash":"d1315807083ca620e65ca7111df847527685df83","type":"INDEX","name":"SM_REACTIONS_IDX1","schemaName":"WKSP_MLEGENAI","sxml":"\n  <INDEX xmlns=\"http://xmlns.oracle.com/ku\" version=\"1.0\">\n   <UNIQUE></UNIQUE>\n   <SCHEMA>WKSP_MLEGENAI</SCHEMA>\n   <NAME>SM_REACTIONS_IDX1</NAME>\n   <TABLE_INDEX>\n      <ON_TABLE>\n         <SCHEMA>WKSP_MLEGENAI</SCHEMA>\n         <NAME>SM_REACTIONS</NAME>\n      </ON_TABLE>\n      <COL_LIST>\n         <COL_LIST_ITEM>\n            <NAME>POST_ID</NAME>\n         </COL_LIST_ITEM>\n         <COL_LIST_ITEM>\n            <NAME>CREATED_BY</NAME>\n         </COL_LIST_ITEM>\n      </COL_LIST>\n      \n   </TABLE_INDEX>\n</INDEX>"}