# Knight's Travails

This project uses a bfs search algorithm to find the shortest path for a Chess Knight from a starting position to an end position.

Both positions are on a standard 8x8 chess board

---

Load the file and create a new instance with the starting positions

```ruby
[1] pry(main)> load 'knightpathfinder.rb'
=> true
[2] pry(main)> kpf = KnightPathfinder.new([0,0])
```

The program builds a move tree to represent the shortest path to a given position, in a breadth-first manner, starting with the root (aka start posiiton)

```ruby
[3] pry(main)> kpf.find_path([7,6])
=> [[0, 0], [2, 1], [4, 0], [5, 2], [6, 4], [7, 6]]
[4] pry(main)> kpf.find_path([6,2])
=> [[0, 0], [2, 1], [4, 2], [5, 0], [6, 2]]
```
