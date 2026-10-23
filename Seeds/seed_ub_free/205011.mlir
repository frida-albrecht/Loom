module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5.928000e+01> : tensor<7x4xf32>}> : () -> tensor<7x4xf32>
    %1 = "tosa.const"() <{values = dense<1.579500e+02> : tensor<7x1xf32>}> : () -> tensor<7x1xf32>
    %2 = tosa.minimum %0, %1 : (tensor<7x4xf32>, tensor<7x1xf32>) -> tensor<7x4xf32>
    %3 = tosa.concat %2, %2 {axis = 0 : i32} : (tensor<7x4xf32>, tensor<7x4xf32>) -> tensor<14x4xf32>
    %4 = tosa.reverse %3 {axis = 1 : i32} : (tensor<14x4xf32>) -> tensor<14x4xf32>
    %cast = tensor.cast %4 : tensor<14x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

