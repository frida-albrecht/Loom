module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-9.710000e+00> : tensor<9x2x10xf32>}> : () -> tensor<9x2x10xf32>
    %1 = tosa.floor %0 : (tensor<9x2x10xf32>) -> tensor<9x2x10xf32>
    %2 = tosa.reduce_sum %1 {axis = 1 : i32} : (tensor<9x2x10xf32>) -> tensor<9x1x10xf32>
    %3 = tosa.abs %2 : (tensor<9x1x10xf32>) -> tensor<9x1x10xf32>
    %cast = tensor.cast %3 : tensor<9x1x10xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

