// Import necessary testing and component dependencies
import { render, screen, waitFor, fireEvent, act } from '@testing-library/react';
import { TeacherDashboard } from '../teacherDashboard';
import { db } from '../../../config/firebase';
import { getDoc, getDocs, collection, doc, query, where } from 'firebase/firestore';

// Setup test environment with Firebase mocks
jest.mock('../../../config/firebase', () => ({
  db: {
    collection: jest.fn(),
    doc: jest.fn(),
  }
}));

// Setup Firestore function mocks with default implementations
jest.mock('firebase/firestore', () => ({
  getDoc: jest.fn(),
  getDocs: jest.fn(),
  collection: jest.fn(),
  doc: jest.fn(),
  query: jest.fn(() => 'mockQuery'),
  where: jest.fn(() => 'mockWhere'),
}));

// Setup chart component mocks to prevent render issues
jest.mock('recharts', () => ({
  ResponsiveContainer: ({ children }) => children,
  BarChart: () => null,
  Bar: () => null,
  XAxis: () => null,
  YAxis: () => null,
  CartesianGrid: () => null,
  Tooltip: () => null,
  Legend: () => null,
  PieChart: () => null,
  Pie: () => null
}));

// Test suite for TeacherDashboard component
describe('TeacherDashboard', () => {
  const mockUserData = {
    ref: { id: 'teacher123' }
  };
  
  const mockHandleReceiveAnswerMap = jest.fn();

  beforeEach(() => {
    jest.clearAllMocks();
    
    // Setup default mock responses
    getDocs.mockResolvedValue({
      docs: [],
      empty: true
    });

    // Setup teacher document mock
    getDoc.mockResolvedValue({
      exists: () => true,
      data: () => ({ fullName: 'Test Teacher' }),
      id: 'teacher123'
    });
  });

  // Test loading state visibility
  it('renders loading state initially', () => {
    render(
      <TeacherDashboard 
        userData={mockUserData} 
        handleReceiveAnswerMap={mockHandleReceiveAnswerMap} 
      />
    );
    
    expect(screen.getByRole('progressbar')).toBeInTheDocument();
  });

  // Test teacher name display after data load
  it('displays teacher name after loading', async () => {
    const mockTeacherName = 'Test Teacher';
    
    // Setup all mocks before render
    getDoc.mockResolvedValue({
        exists: () => true,
        data: () => ({ fullName: mockTeacherName }),
        id: 'teacher123'
    });

    getDocs.mockResolvedValue({
        docs: [],
        empty: true
    });

    // Wrap the entire render and async operations in act
    await act(async () => {
        render(
            <TeacherDashboard 
                userData={mockUserData} 
                handleReceiveAnswerMap={mockHandleReceiveAnswerMap} 
            />
        );
        
        // Wait for all promises to resolve
        await Promise.resolve();
        // Wait a tick for state updates to process
        await new Promise(resolve => setTimeout(resolve, 0));
    });

    // Assertions after act is complete
    const heading = screen.getByRole('heading', { 
        level: 4,
        name: new RegExp(`Welcome,\\s*${mockTeacherName}`, 'i')
    });
    expect(heading).toBeInTheDocument();
  });

  // Test class list rendering with mock data
  it('displays class list after loading', async () => {
    const mockClasses = [
      { id: 'class1', className: 'Math Class' },
      { id: 'class2', className: 'Science Class' }
    ];

    // Mock teacher document
    getDoc.mockResolvedValueOnce({
      exists: () => true,
      data: () => ({ fullName: 'Test Teacher' }),
      id: 'teacher123'
    });

    // Mock classRefs collection
    getDocs.mockResolvedValueOnce({
      docs: mockClasses.map(cls => ({
        data: () => ({
          classRef: { 
            id: cls.id,
            path: `classes/${cls.id}`
          }
        }),
        id: cls.id
      }))
    });

    // Mock class documents
    mockClasses.forEach(cls => {
      getDoc.mockResolvedValueOnce({
        exists: () => true,
        data: () => ({ className: cls.className }),
        id: cls.id
      });
    });

    await act(async () => {
      render(
        <TeacherDashboard 
          userData={mockUserData} 
          handleReceiveAnswerMap={mockHandleReceiveAnswerMap} 
        />
      );
    });

    await waitFor(() => {
      expect(screen.getByText('Math Class')).toBeInTheDocument();
      expect(screen.getByText('Science Class')).toBeInTheDocument();
    });
  });

  // Test class selection and related data fetching
  it('handles class selection', async () => {
    const mockClass = {
      id: 'class1',
      className: 'Math Class',
      classRefData: {
        classRef: {
          path: 'classes/class1',
          id: 'class1'
        }
      }
    };

    // Mock initial data loading
    getDoc.mockResolvedValueOnce({
      exists: () => true,
      data: () => ({ fullName: 'Test Teacher' }),
      id: 'teacher123'
    });

    getDocs.mockResolvedValueOnce({
      docs: [{
        data: () => ({
          classRef: { 
            id: mockClass.id,
            path: mockClass.classRefData.classRef.path 
          }
        }),
        id: mockClass.id
      }]
    });

    getDoc.mockResolvedValueOnce({
      exists: () => true,
      data: () => ({ className: mockClass.className }),
      id: mockClass.id
    });

    // Mock empty results for subsequent collection queries
    getDocs.mockResolvedValueOnce({ docs: [] }); // students
    getDocs.mockResolvedValueOnce({ docs: [] }); // subjects/topics
    getDocs.mockResolvedValueOnce({ docs: [] }); // allowedGames

    await act(async () => {
      render(
        <TeacherDashboard 
          userData={mockUserData} 
          handleReceiveAnswerMap={mockHandleReceiveAnswerMap} 
        />
      );
    });

    const classButton = await screen.findByText('Math Class');
    
    await act(async () => {
      fireEvent.click(classButton);
    });

    // Update expectations to match the actual paths being used in the component
    expect(collection).toHaveBeenNthCalledWith(2, db, 'classes/class1', 'students');
    expect(collection).toHaveBeenNthCalledWith(3, db, 'classes/class1/topics');
    expect(collection).toHaveBeenNthCalledWith(4, db, 'classes/class1/allowedGames');
  });

  it('fetches class sessions and answers', async () => {
    const mockClass = {
      id: 'class1',
      className: 'Math Class',
      classRefData: {
        classRef: {
          path: 'classes/class1',
          id: 'class1'
        }
      }
    };

    const mockStudentList = [
      { id: 'student1', name: 'John Doe' },
      { id: 'student2', name: 'Jane Smith' }
    ];

    // Mock initial teacher document
    getDoc.mockResolvedValueOnce({
      exists: () => true,
      data: () => ({ fullName: 'Test Teacher' }),
      id: 'teacher123'
    });

    // Mock classRefs collection
    const mockTeacherDocRef = { id: 'teacher123' };
    doc.mockReturnValueOnce(mockTeacherDocRef);
    
    getDocs.mockResolvedValueOnce({
      docs: [{
        data: () => ({
          classRef: { 
            id: mockClass.id,
            path: mockClass.classRefData.classRef.path 
          }
        }),
        id: mockClass.id
      }]
    });

    // Mock class document
    getDoc.mockResolvedValueOnce({
      exists: () => true,
      data: () => ({ className: mockClass.className }),
      id: mockClass.id
    });

    // Mock collections data
    const mockStudentData = {
      docs: [
        {
          id: 'student1',
          data: () => ({
            studentRef: { 
              path: 'students/student1',
              id: 'student1'
            }
          })
        }
      ]
    };
    getDocs.mockResolvedValueOnce(mockStudentData);
    getDocs.mockResolvedValueOnce({ docs: [] }); // subjects/topics
    getDocs.mockResolvedValueOnce({ docs: [] }); // allowedGames

    // Initialize component
    let component;
    await act(async () => {
      component = render(
        <TeacherDashboard 
          userData={{ ref: { id: 'teacher123' } }}
          handleReceiveAnswerMap={jest.fn()}
        />
      );
    });

    // Wait for initial class to load and click it
    const classButton = await screen.findByText('Math Class');
    await act(async () => {
      fireEvent.click(classButton);
    });

    // Verify the sequence of collection calls
    expect(doc).toHaveBeenCalledWith(db, 'teachers', 'teacher123');
    expect(collection).toHaveBeenNthCalledWith(1, mockTeacherDocRef, 'classRefs');
    expect(collection).toHaveBeenNthCalledWith(2, db, 'classes/class1', 'students');
    expect(collection).toHaveBeenNthCalledWith(3, db, 'classes/class1/topics');
    expect(collection).toHaveBeenNthCalledWith(4, db, 'classes/class1/allowedGames');

    // Wait for the state to be updated
    await waitFor(() => {
      expect(component.getByText('Class Statistics')).toBeInTheDocument();
    });
  });
});