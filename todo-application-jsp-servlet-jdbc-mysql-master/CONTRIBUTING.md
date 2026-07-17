# Contributing to Todo Application

Thank you for your interest in contributing to this project! 🎉

## How to Contribute

### Reporting Bugs
1. Check if the bug has already been reported in [Issues](https://github.com/Abhishekjc19/Todo-Application-Jsp-Servlet-Jdbc/issues)
2. If not, create a new issue with:
   - Clear title and description
   - Steps to reproduce
   - Expected vs actual behavior
   - Environment details (OS, Java version, Tomcat version, Oracle version)
   - Screenshots if applicable

### Suggesting Features
1. Check existing feature requests in Issues
2. Create a new issue with:
   - Clear feature description
   - Use case and benefits
   - Proposed implementation (optional)

### Code Contributions

#### 1. Fork the Repository
```bash
git clone https://github.com/Abhishekjc19/Todo-Application-Jsp-Servlet-Jdbc.git
cd Todo-Application-Jsp-Servlet-Jdbc
```

#### 2. Create a Branch
```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/your-bug-fix
```

#### 3. Make Your Changes
- Write clean, readable code
- Follow Java naming conventions
- Add comments for complex logic
- Update documentation if needed

#### 4. Test Your Changes
- Test all affected functionality
- Ensure no existing features are broken
- Test on both development and production configurations

#### 5. Commit Your Changes
```bash
git add .
git commit -m "feat: add user profile feature"
# or
git commit -m "fix: resolve login session timeout issue"
```

Use conventional commit messages:
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `style:` - Code style changes (formatting, etc.)
- `refactor:` - Code refactoring
- `test:` - Adding tests
- `chore:` - Maintenance tasks

#### 6. Push and Create Pull Request
```bash
git push origin feature/your-feature-name
```

Then create a Pull Request on GitHub with:
- Clear description of changes
- Related issue numbers
- Screenshots (for UI changes)
- Testing notes

## Code Style Guidelines

### Java Code
- Use 4 spaces for indentation
- Follow Java naming conventions:
  - Classes: `PascalCase`
  - Methods/Variables: `camelCase`
  - Constants: `UPPER_SNAKE_CASE`
- Add JavaDoc comments for public methods
- Keep methods focused and under 50 lines when possible

### JSP/HTML
- Use 2 spaces for indentation
- Use meaningful attribute names
- Keep JSP scriptlets minimal (prefer JSTL)

### SQL
- Use uppercase for SQL keywords
- Use lowercase for table/column names
- Include comments for complex queries

## Project Structure

```
src/
├── dao/        - Database access layer
├── model/      - Entity classes
├── utils/      - Utility classes
└── web/        - Servlets (controllers)

WebContent/
├── common/     - Reusable JSP components
├── login/      - Login pages
├── register/   - Registration pages
├── todo/       - Todo management pages
└── WEB-INF/    - Configuration and libraries
```

## Testing Guidelines

Before submitting a PR:
- [ ] Code compiles without errors
- [ ] Application runs successfully on Tomcat
- [ ] Login/logout works correctly
- [ ] CRUD operations work for todos
- [ ] User registration works
- [ ] No console errors
- [ ] Responsive design works on mobile

## Need Help?

- Check the [README](README.md) for setup instructions
- Review existing [Issues](https://github.com/Abhishekjc19/Todo-Application-Jsp-Servlet-Jdbc/issues)
- Ask questions in issue comments

## Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Focus on the code, not the person
- Help newcomers learn and contribute

Thank you for contributing! 🚀
