class ApiPath {
  static String job(String uid, String jobId) => 'users/$uid/jobs/$jobId';

  //this path points to all the jobs that has been created by a specific user
  static String jobs(String uid) => 'users/$uid/jobs';
}
