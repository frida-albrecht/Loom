module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.190700e+02> : tensor<6x1x5x5xf32>}> : () -> tensor<6x1x5x5xf32>
    %1 = tosa.floor %0 : (tensor<6x1x5x5xf32>) -> tensor<6x1x5x5xf32>
    %2 = tosa.identity %1 : (tensor<6x1x5x5xf32>) -> tensor<6x1x5x5xf32>
    %3 = tosa.floor %2 : (tensor<6x1x5x5xf32>) -> tensor<6x1x5x5xf32>
    %4 = tosa.reverse %3 {axis = 2 : i32} : (tensor<6x1x5x5xf32>) -> tensor<6x1x5x5xf32>
    %cast = tensor.cast %4 : tensor<6x1x5x5xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

