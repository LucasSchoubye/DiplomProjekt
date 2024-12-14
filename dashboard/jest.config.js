// jest.config.js
module.exports = {
  testEnvironment: 'jsdom',
  setupFilesAfterEnv: ['<rootDir>/src/setupTests.js'],
  moduleNameMapper: {
    '\\.(css|less|scss|sass)$': 'identity-obj-proxy',
    '\\.(jpg|jpeg|png|gif|webp|svg)$': '<rootDir>/__mocks__/fileMock.js'
  },
  testEnvironmentOptions: {
    url: 'http://localhost'
  },
  transform: {
    '^.+\\.(js|jsx)$': 'babel-jest'
  },
  globals: {
    TextEncoder: require('util').TextEncoder,
    TextDecoder: require('util').TextDecoder,
    ReadableStream: require('web-streams-polyfill').ReadableStream
  }
};