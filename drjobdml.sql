set serveroutput on
declare
  job1 number;
  job2 number;
  job3 number;
  job4 number;
  job5 number;
begin
  dbms_job.submit(job1, 'ctx_ddl.sync_index(''inverse_first_name'');',
                  interval=>'SYSDATE+0/1440');
  commit;
  dbms_output.put_line('job1 '||job1||' has been submitted.');
  
  
  dbms_job.submit(job2, 'ctx_ddl.sync_index(''inverse_last_name'');',
                  interval=>'SYSDATE+0/1440');
  commit;
  dbms_output.put_line('job2 '||job2||' has been submitted.');


  dbms_job.submit(job3, 'ctx_ddl.sync_index(''inverse_description'');',
                  interval=>'SYSDATE+0/1440');
  commit;
  dbms_output.put_line('job3 '||job3||' has been submitted.');
  
  
  
  dbms_job.submit(job4, 'ctx_ddl.sync_index(''inverse_diagnosis'');',
                  interval=>'SYSDATE+0/1440');
  commit;
  dbms_output.put_line('job4 '||job4||' has been submitted.');
  
  
  
  dbms_job.submit(job5, 'ctx_ddl.sync_index(''inverse_test_type'');',
                  interval=>'SYSDATE+0/1440');
  commit;
  dbms_output.put_line('job5 '||job5||' has been submitted.');
  
  
end;