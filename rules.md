# Vibe Coding Development Rules

This document outlines the **coding conventions**, **Git workflow**, and **best practices** to follow for Java development and collaborative coding.

---

## 1. Coding Conventions

### 1.1 Naming Conventions

- **Classes and Interfaces**
  - Use `PascalCase` for class and interface names.
  - Interface names may optionally start with `I` (team preference).
  - Example:
    ```java
    public class UserService { }
    public interface AuthService { }
    ```

- **Methods**
  - Use `camelCase` for method names.
  - Method names should be verbs describing the action.
  - Example:
    ```java
    public void calculateTotalPrice() { }
    ```

- **Variables**
  - Use `camelCase` for variables.
  - Use `UPPER_SNAKE_CASE` for constants.
  - Example:
    ```java
    private int totalAmount;
    private static final int MAX_ITEM_COUNT = 100;
    ```

- **Packages**
  - Use lowercase letters with words separated by dots.
  - Example: `com.myapp.services`

- **File Names**
  - File names must match the class/interface name exactly.
  - Example: `UserService.java`, `AuthService.java`

---

### 1.2 Indentation and Formatting

- **Indentation:** 4 spaces per indentation level.  
- **Line Length:** Max 120 characters.  
- **Braces:** Always use braces `{}` for control statements, even single-line blocks.
  ```java
  if (condition) {
      doSomething();
  }
  ```
- **Blank Lines:** Use blank lines to separate logical blocks (e.g., between fields and methods).

---

### 1.3 Commenting

- **Class-level and Method-level Documentation**
  - Use Javadoc with descriptions, parameters, and return values.
  - Example:
    ```java
    /**
     * Calculates the total price for all items in the cart.
     * @param items List of items to calculate the total.
     * @return The total price.
     */
    public double calculateTotalPrice(List<Item> items) {
        // logic here
    }
    ```

- **Inline Comments**
  - Use for complex or tricky logic.
  - Example:
    ```java
    // Apply discount if user is a premium member
    if (user.isPremium()) {
        applyDiscount();
    }
    ```

---

### 1.4 Error Handling

- Always use `try-catch` blocks with meaningful messages.
  ```java
  try {
      connectToDatabase();
  } catch (SQLException e) {
      System.err.println("Failed to connect to the database: " + e.getMessage());
  }
  ```

---

## 2. Git Workflow

### 2.1 Branching Rules

- Always branch off from `dev`.  
- Never commit directly to `dev` or `main`.  

**Branch Naming Conventions:**
- Feature Branch: `feature/pp-XXXX`  
  Example: `feature/pp-1234-add-login-functionality`
- Fix Branch: `fix/pp-XXXX`  
  Example: `fix/pp-5678-fix-login-bug`

---

### 2.2 Syncing with `dev`

Before starting work:
```bash
git checkout dev
git pull origin dev
```

Before pushing changes:
```bash
git checkout dev
git pull origin dev
git checkout <your-branch>
git merge dev
```
Resolve conflicts if needed, then commit.

---

### 2.3 Committing Changes

- **Format:**  
  - Feature: `feature/pp-XXXX: short description`  
  - Fix: `fix/pp-XXXX: short description`  

- **Examples:**
  ```bash
  git commit -m "feature/pp-1234: Add login functionality"
  git commit -m "fix/pp-5678: Fix login validation error"
  ```

---

### 2.4 Pushing Changes

```bash
git push origin <your-branch>
```

---

### 2.5 Pull Requests (PRs)

- Create PRs into `dev`.  
- Always include clear descriptions.  
- Assign reviewers and address feedback.  

Rebase if conflicts:
```bash
git rebase dev
```

---

### 2.6 Merging

- Never merge directly into `main` or `dev` without approval.  
- Use **Merge with Squash** to keep history clean.  

---

## 3. Good Practices

### 3.1 Always Branch Off `dev`
Each feature/fix must branch from `dev`.

### 3.2 Stay Up to Date
Always pull latest changes before starting work:
```bash
git pull origin dev
```

### 3.3 Write Unit Tests
Follow TDD where possible. Use JUnit or TestNG.

Example:
```java
@Test
public void testCalculateTotalPrice() {
    List<Item> items = Arrays.asList(new Item("Apple", 1.0), new Item("Banana", 1.5));
    double total = cart.calculateTotalPrice(items);
    assertEquals(total, 2.5, 0.01);
}
```

### 3.4 Keep Commits Atomic
Each commit should represent one logical change. Avoid mixing unrelated changes.

### 3.5 Avoid Large Pull Requests
Keep PRs small, focused, and easier to review.

### 3.6 Code Review Process
Reviewers should check:
- Code quality & consistency
- Performance
- Logic correctness
- Test coverage

### 3.7 CI/CD
Ensure CI/CD pipelines pass before merging. Never merge breaking code.

### 3.8 Documentation
Update README and API docs when making changes.

### 3.9 Avoid Hardcoding
Use configuration files or environment variables for sensitive/environment data.

---

## 4. Git Commands

### 4.1 Staging Files
```bash
git add .              # stage all files
git add file1 file2    # stage specific files
```

### 4.2 Committing
```bash
git commit -m "pp-XXXXX your_commit_message"
```

### 4.3 Pushing
```bash
git push origin branch_name
```

### 4.4 Pulling
```bash
git pull origin branch_name
```

### 4.5 Branching & Checkout
```bash
git branch branch_name     # create branch
git checkout branch_name   # switch branch
git status                 # check staged files before branching
```


### 4.6 ticket / issues will be "tasks" folder, a text folder is expected with the issue name and ticket number 
implementation details would be given there 
