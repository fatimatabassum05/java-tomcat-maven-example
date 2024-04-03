pipeline{
	agent any
	stages {
		stage('Checkout') {
			steps {
        echo "Checkout completed"
			}
		}

		stage('Test') {
			steps {
				echo "Running static tests on code"
			}
		}

		stage('Build') {
      			when {
        			branch "master"
      			}
			steps {
				sh 'echo "Building the code"'
			}
		}

		stage('Deploy') {
			steps {
				echo "deploying into environment"
			}
		}

	}
}
