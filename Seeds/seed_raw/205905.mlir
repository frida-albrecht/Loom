module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.081900e+02> : tensor<9x6x1x5xf32>}> : () -> tensor<9x6x1x5xf32>
    %1 = tosa.log %0 : (tensor<9x6x1x5xf32>) -> tensor<9x6x1x5xf32>
    %2 = tosa.reduce_min %1 {axis = 1 : i32} : (tensor<9x6x1x5xf32>) -> tensor<9x1x1x5xf32>
    %3 = tosa.add %2, %2 : (tensor<9x1x1x5xf32>, tensor<9x1x1x5xf32>) -> tensor<9x1x1x5xf32>
    %4 = tosa.abs %3 : (tensor<9x1x1x5xf32>) -> tensor<9x1x1x5xf32>
    %cast = tensor.cast %4 : tensor<9x1x1x5xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

