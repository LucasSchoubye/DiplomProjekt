import '@testing-library/jest-dom';
import { ReadableStream } from 'web-streams-polyfill';

// Mock ResizeObserver
class ResizeObserver {
  observe() {}
  unobserve() {}
  disconnect() {}
}

window.ResizeObserver = ResizeObserver;

// Add text encoder/decoder polyfills
const { TextEncoder, TextDecoder } = require('util');
global.TextEncoder = TextEncoder;
global.TextDecoder = TextDecoder;

// Add ReadableStream polyfill
global.ReadableStream = ReadableStream;
