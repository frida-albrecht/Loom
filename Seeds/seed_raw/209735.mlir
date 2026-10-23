module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.463000e+01> : tensor<9x9x5x10xf32>}> : () -> tensor<9x9x5x10xf32>
    %1 = tosa.abs %0 : (tensor<9x9x5x10xf32>) -> tensor<9x9x5x10xf32>
    %2 = tosa.reverse %1 {axis = 3 : i32} : (tensor<9x9x5x10xf32>) -> tensor<9x9x5x10xf32>
    %3 = tosa.maximum %2, %1 : (tensor<9x9x5x10xf32>, tensor<9x9x5x10xf32>) -> tensor<9x9x5x10xf32>
    %4 = tosa.exp %3 : (tensor<9x9x5x10xf32>) -> tensor<9x9x5x10xf32>
    %cast = tensor.cast %4 : tensor<9x9x5x10xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

