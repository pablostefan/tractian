class TreeNode<T> {
  final T value;
  List<TreeNode> children;

  TreeNode({required this.value, this.children = const []});
}
