#!/usr/bin/env groovy
import groovy.json.JsonOutput

def SRC_DIR = "function"
def TESTS_DIR = "tests"

def runCommand(String command) {
  sh '#!/bin/bash\n' + command
}

def runEnvCommand(String command) {
  sh '#!/bin/bash\nsource venv/bin/activate\n' + command
}

pipeline {
  agent any
  stages {
    stage('Install dependencies') {
      agent {
        docker {
          image 'python:3.11-slim'
          reuseNode true
        }
      }
      steps {
        runCommand('python3 -m venv ./venv')
        runEnvCommand('pip3 install -r ' + SRC_DIR + '/requirements.txt')
        runEnvCommand('pip3 install -r ' + TESTS_DIR + '/requirements.txt')
      }
    }
    stage('Running Unit Tests') {
      agent {
        docker {
          image 'python:3.11-slim'
          reuseNode true
        }
      }
      steps {
        runEnvCommand('pytest -v --cov-report xml:reports/coverage-unit.xml --junitxml=reports/xunit-result-unit.xml --cov ' + SRC_DIR)
      }
    }
  }
  post {
    always {
      deleteDir()
    }
  }
  options {
    buildDiscarder(logRotator(numToKeepStr: '3'))
    timeout(time: 60, unit: 'MINUTES')
  }
}
