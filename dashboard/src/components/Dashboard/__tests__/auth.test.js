import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import { Auth } from '../../auth';
import { signInWithEmailAndPassword } from 'firebase/auth';
import { collection, query, getDocs } from 'firebase/firestore';

// Mock Firebase modules
jest.mock('firebase/auth');
jest.mock('firebase/firestore');
jest.mock('../../../config/firebase', () => ({
    auth: {},
    db: {}
}));

describe('Auth Component', () => {
  const mockOnLoginSuccess = jest.fn();

  beforeEach(() => {
    // Clear all mocks before each test
    jest.clearAllMocks();
  });

  it('renders login form by default', () => {
    render(<Auth onLoginSuccess={mockOnLoginSuccess} />);
    
    expect(screen.getByLabelText(/Email/i)).toBeInTheDocument();
    expect(screen.getByLabelText(/Password/i)).toBeInTheDocument();
    expect(screen.getByRole('button', { name: /Sign In/i })).toBeInTheDocument();
  });

  it('handles empty email/password submission', async () => {
    render(<Auth onLoginSuccess={mockOnLoginSuccess} />);
    
    // Clear default values
    const emailInput = screen.getByLabelText(/Email/i);
    const passwordInput = screen.getByLabelText(/Password/i);
    fireEvent.change(emailInput, { target: { value: '' } });
    fireEvent.change(passwordInput, { target: { value: '' } });
    
    // Click sign in
    fireEvent.click(screen.getByRole('button', { name: /Sign In/i }));

    // Check for error message
    await waitFor(() => {
      expect(screen.getByText(/Email and password are required/i)).toBeInTheDocument();
    });
  });

  it('handles successful teacher login', async () => {
    const mockUserData = {
      role: 'Teacher',
      uid: 'test-uid'
    };

    // Mock Firebase auth success
    signInWithEmailAndPassword.mockResolvedValueOnce({
      user: { uid: 'test-uid' }
    });

    // Mock Firestore query success
    getDocs.mockResolvedValueOnce({
      empty: false,
      docs: [{
        data: () => mockUserData
      }]
    });

    render(<Auth onLoginSuccess={mockOnLoginSuccess} />);

    // Trigger login
    fireEvent.click(screen.getByRole('button', { name: /Sign In/i }));

    // First wait for success message
    await waitFor(() => {
      expect(screen.getByText(/User signed in successfully/i)).toBeInTheDocument();
    });

    // Then wait for callback with longer timeout since it has a setTimeout
    await waitFor(() => {
      expect(mockOnLoginSuccess).toHaveBeenCalledWith(mockUserData);
    }, { timeout: 2000 }); // Increase timeout to account for the 1000ms setTimeout
  });

  it('handles non-teacher user login attempt', async () => {
    // Mock Firebase auth success but non-teacher role
    signInWithEmailAndPassword.mockResolvedValueOnce({
      user: { uid: 'test-uid' }
    });

    // Mock Firestore query returning non-teacher user
    getDocs.mockResolvedValueOnce({
      empty: false,
      docs: [{
        data: () => ({
          role: 'Student',
          uid: 'test-uid'
        })
      }]
    });

    render(<Auth onLoginSuccess={mockOnLoginSuccess} />);

    fireEvent.click(screen.getByRole('button', { name: /Sign In/i }));

    await waitFor(() => {
      expect(screen.getByText(/User is not a teacher/i)).toBeInTheDocument();
    });
  });

  it('handles Firebase authentication error', async () => {
    // Mock Firebase auth failure
    signInWithEmailAndPassword.mockRejectedValueOnce(new Error('Invalid credentials'));

    render(<Auth onLoginSuccess={mockOnLoginSuccess} />);

    fireEvent.click(screen.getByRole('button', { name: /Sign In/i }));

    await waitFor(() => {
      expect(screen.getByText(/Authentication error:/i)).toBeInTheDocument();
    });
  });

  it('toggles between login and signup forms', () => {
    render(<Auth onLoginSuccess={mockOnLoginSuccess} />);

    // Click signup button to switch to signup form
    fireEvent.click(screen.getByRole('button', { name: /Sign Up/i }));

    // Verify signup form is shown by checking for unique elements
    expect(screen.getByLabelText(/Username/i)).toBeInTheDocument();
    expect(screen.getByLabelText(/Confirm Password/i)).toBeInTheDocument();

    // Click back arrow 
    fireEvent.click(screen.getByTestId('ArrowBackIcon'));

    // Verify login form is shown again by checking for unique login elements
    expect(screen.getByRole('button', { name: /Sign In/i })).toBeInTheDocument();
  });
});