module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %cst = arith.constant 3.356000e+01 : f32
    %cst_0 = arith.constant -1.589300e+02 : f32
    %c6 = arith.constant 6 : index
    %0 = bufferization.alloc_tensor() : tensor<5xf32>
    %inserted = tensor.insert %cst into %0[%c6] : tensor<5xf32>
    %inserted_1 = tensor.insert %cst_0 into %0[%c6] : tensor<5xf32>
    %cast = tensor.cast %inserted : tensor<5xf32> to tensor<*xf32>
    %cast_2 = tensor.cast %inserted_1 : tensor<5xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_2) : (tensor<*xf32>) -> ()
    return
  }
}

