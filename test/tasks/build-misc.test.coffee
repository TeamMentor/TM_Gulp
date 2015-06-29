describe '| tasks | build-coffee', ->

  run_Task = (task, callback)->
    target = 'gulp'
    target.start_Process_Capture_Console_Out task  , callback

  it 'coffee', (done)->
    @.timeout 5000
    run_Task 'coffee', (result)->
      log result
      done()

  it 'help', (done)->
    run_Task 'help', (result)->
      result.assert_Contains ['Main Tasks', 'Sub Tasks']
      done()

  it.only 'angular', (done)->
    @.timeout 5000
    run_Task 'angular', (result)->
      log result
      done()