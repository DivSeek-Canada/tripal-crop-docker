5<?php
require_once '../galaxy.inc';
require_once 'testConfig.inc';


class JobsTest extends phpunitClass {


  /**
   * Intializes the Galaxy object for all of the tests.
   *
   * This function provides the $galaxy object to all other tests as they
   * are dependent on this one.
   */
  function testInitGalaxy() {
    global $config;

    // Connect to Galaxy.
    $galaxy = new GalaxyInstance($config['host'], $config['port'], FALSE);
    $success = $galaxy->authenticate($config['email'], $config['pass']);
    $this->assertTrue($success, $galaxy->getErrorMessage());

    return $galaxy;
  }

  /**
   * Tests the retreival of specified jobs for the given user
   *
   * @depends testInitGalaxy
   */
  public function testIndex($galaxy){

    $jobs = new GalaxyJobs($galaxy);

    // There will be 7 cases to cover the testing,
    // One test for each of the parameters, one for all the input params
    // entered, and on for all the input params being null

    // Case One: All parameters are null
    $inputs = array();
    $default = $jobs->index($inputs);
    $this->assertTrue(is_array($default), $galaxy->getErrorMessage());

    // Case Two: Looking for jobs that are in a queued state (the array may
    // be empty if you do not have any queued jobs)
    $inputs = array();
    $inputs['state'] = 'queued';

    $index = $jobs->index($inputs);
    $this->assertTrue(is_array($index), $galaxy->getErrorMessage());

    // Case Three: Assuming that the tools test suite was ran before this suite
    // we will have at least 1 job id to search for when we run the index
    // with a given job id number to look for
    array_shift($inputs);
    if(!empty($default))
      $inputs['tool_ids'] =  $default[0]['tool_id'];

    $index = $jobs->index($inputs);
    $this->assertTrue(is_array($index), $galaxy->getErrorMessage());

    // Case Four: Limit the search of jobs updated AFTER the specified date
    // This date is arbitrarily chosen
    array_shift($inputs);
    $inputs['date_range_min'] = '2015-12-09';

    $index = $jobs->index($inputs);
    $this->assertTrue(is_array($index), $galaxy->getErrorMessage());

    // Case Five: Limit the search of jobs updated BEFORE this date
    // This date is also arbitrarily chosen
    array_shift($inputs);
    $inputs['date_range_max'] = '2016-03-09';

    $index = $jobs->index($inputs);
    $this->assertTrue(is_array($index), $galaxy->getErrorMessage());

    // Case Six: Similar to Case Three with the difference of the history
    // id instead of the tool_id
    // TODO: I'm not sure about the $history_id interaction with index
    // this should be addressed later
    array_shift($inputs);
    if(!empty($default))
    $inputs['history_id'] = $default[0]['id'];

    $index = $jobs->index($inputs);
    $this->assertTrue(is_array($index), $galaxy->getErrorMessage());

    // Case Seven: Enable all of the input params, this will elicit a empty
    // array (at least it should)
    $inputs['state'] = 'paused';
    if(!empty($default))
      $inputs['tool_ids'] = $default[0]['tool_id'];
	  
    $inputs['date_range_min'] = '2014-12-09';
//    $inputs['date_range_max'] = '2017-06-09';

    $index = $jobs->index($inputs );
    $this->assertTrue(is_array($index), $galaxy->getErrorMessage());

    return $default;
  }


  /**
   * Tests whether the function will return a specified tool's input datasets.
   *
   * @depends testIndex
   * @depends testInitGalaxy
   *
   * The jobs function will rely on the tools working
   */
  public function testInputs($default, $galaxy){
    $jobs = new GalaxyJobs($galaxy);

    $params = array();
    if(!empty($default))
      $params['job_id'] = $default[0]['id'];

    $inputs = $jobs->inputs($params);

    $this->assertTrue(is_array($inputs), $galaxy->getErrorMessage());
  }

  /**
   * Tests whether the function will return a specified tool's output datasets.
   *
   * @depends testIndex
   * @depends testInitGalaxy
   *
   * The jobs function will rely on the tools working
   */
  public function testOutputs($default, $galaxy){
    $jobs = new GalaxyJobs($galaxy);

    $params = array();
    if(!empty($default))
      $params['job_id'] = $default[0]['id'];

    $outputs = $jobs->outputs($params);

    $this->assertTrue(is_array($outputs), $galaxy->getErrorMessage());
  }

  /**
   * Tests whether the function will return a specified tool's metadata.
   *
   * @depends testIndex
   * @depends testInitGalaxy
   *
   * The jobs function will rely on the tools working
   */
  public function testShow($default, $galaxy){
    $jobs = new GalaxyJobs($galaxy);

    $params = array();
    if(!empty($default))
      $params['job_id'] = $default[0]['id'];

    $show = $jobs->show($params);

    $this->assertTrue(is_array($show), $galaxy->getErrorMessage());
    $this->assertTrue(array_key_exists('tool_id', $show), 'Did not return a valid job.');
  }

  /**
   * Tests Job's buildForRerun function
   * Builds a job for rerun
   *
   *
   * This function is incomplete, please see our issues page on github for more information.
   * TODO: Currently the standard key authentication does not work with this
   *  function
   *  https://github.com/tripal/blend4php/issues/13
   * @depends testIndex
   * @depends testInitGalaxy
   */
  public function testBuildForReRun($default, $galaxy){
    $jobs = new GalaxyJobs($galaxy);
	$tool = new GalaxyTools($galaxy);
	$history = new GalaxyHistories($galaxy);
	$history_contents = new GalaxyHistoryContents($galaxy);
	
	$hist_id = $history->getMostRecentlyUsed()['id'];
	$content  = $history_contents->index(array('history_id' => $hist_id));
	
	$test = $tool->create( array('tool_id' => 'wc_gnu',
															'history_id' => $hist_id));
	// the wc_gnu tool is default to galaxy so use that for rerun
	// because you can't use upload1 to  build for rerun
	
    // Case 1: Successfully build for rerun given a correct job id
    $inputs = array();
    
	// Grab the wc_gnu tool from the top as it should be the must recently queued/running job
	$inputs['id'] = $jobs->index(array())[0]['id'];

    $rerun_job = $jobs->buildForRerun($inputs);
    $this->assertTrue(is_array($rerun_job), $galaxy->getErrorMessage());
  }

  /**
   * TODO: Input params are not correct
   *  We need to fix them at some point
   *  https://github.com/tripal/GalaxyPAPI/issues/8
   *
   *
   * @depends testIndex
   * @depends testInitGalaxy
   */
  public function testSearch($default, $galaxy){

    $jobs = new GalaxyJobs($galaxy);

    $job = $jobs->search(array(
      'tool_id' => 'upload1',
//       'inputs' => array('id' => '03501d7626bd192f', 'dataset_id' => '03501d7626bd192f'),
//       'status' => 'ok',
    ));
    //print_r($job);
    //$this->assertTrue(is_array($job), $galaxy->getErrorMessage());
    //$this->assertTrue(!empty($job), "Job search returned no results.");

    // This function, for now, should always return false.
    $this->assertFalse($job, "Jobs search should return false");
  }
}
