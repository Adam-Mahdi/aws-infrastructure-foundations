# Git Workflow

This document outlines the Git workflow to follow for this project.

## Branching Strategy

We use a feature-based branching strategy:

1. **main** - The main branch contains production-ready code
2. **feature/*** - Feature branches for new development
3. **bugfix/*** - Branches for bug fixes
4. **docs/*** - Documentation updates

## Workflow

1. **Create a branch**:
   ```bash
   git checkout main
   git pull
   git checkout -b feature/your-feature-name
   ```

2. **Make changes**:
   - Make focused, small commits
   - Use descriptive commit messages
   - Commit frequently

3. **Push your branch**:
   ```bash
   git push -u origin feature/your-feature-name
   ```

4. **Create a Pull Request**:
   - Go to GitHub and create a PR from your branch to main
   - Add a description explaining the changes
   - Request reviews from team members

5. **Review and iterate**:
   - Address feedback from reviewers
   - Make additional commits as needed

6. **Merge**:
   - Once approved, merge the PR into main
   - Delete the feature branch when it's no longer needed

## Commit Message Guidelines

Good commit messages:
- Start with a verb (Add, Fix, Update, Refactor, etc.)
- Be concise but descriptive
- Reference issue numbers when applicable

Examples:
- "Add IAM module with least privilege permissions"
- "Fix security group rule for database access"
- "Update README with deployment instructions"

## Best Practices

- Never commit directly to main
- Keep branches short-lived (1-3 days if possible)
- Rebase feature branches on main before creating a PR
- Squash commits when appropriate for a cleaner history
- Write proper tests for your changes