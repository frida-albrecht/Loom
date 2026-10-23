module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %c0_i32 = arith.constant 0 : i32
    %alloc = memref.alloc() : memref<1x1x8x4x4x8xi32>
    %0 = tensor.empty() : tensor<1x1x16x64xi32>
    %extracted_slice = tensor.extract_slice %0[0, 0, 0, 0] [1, 1, 16, 64] [1, 1, 1, 1] : tensor<1x1x16x64xi32> to tensor<1x1x16x64xi32>
    %1 = linalg.fill ins(%c0_i32 : i32) outs(%extracted_slice : tensor<1x1x16x64xi32>) -> tensor<1x1x16x64xi32>
    %2 = bufferization.to_tensor %alloc restrict writable : memref<1x1x8x4x4x8xi32> to tensor<1x1x8x4x4x8xi32>
    %pack = linalg.pack %1 outer_dims_perm = [0, 1, 3, 2] inner_dims_pos = [2, 3] inner_tiles = [4, 8] into %2 : tensor<1x1x16x64xi32> -> tensor<1x1x8x4x4x8xi32>
    %cast = tensor.cast %pack : tensor<1x1x8x4x4x8xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

