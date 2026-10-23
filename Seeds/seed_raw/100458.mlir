module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %c2 = arith.constant 2 : index
    %c4 = arith.constant 4 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = tensor.empty() : tensor<4x2xf32>
    %1 = scf.forall (%arg0, %arg1) in (%c4, %c2) shared_outs(%arg2 = %0) -> (tensor<4x2xf32>) {
      %2 = tensor.empty() : tensor<1x1xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<1x1xf32>) -> tensor<1x1xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %3 into %arg2[%arg0, %arg1] [1, 1] [1, 1] : tensor<1x1xf32> into tensor<4x2xf32>
      }
    }
    %cast = tensor.cast %1 : tensor<4x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

