module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.451100e+02> : tensor<4xf32>}> : () -> tensor<4xf32>
    %1 = "tosa.const"() <{values = dense<5.410000e+01> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = tosa.maximum %0, %1 : (tensor<4xf32>, tensor<1xf32>) -> tensor<4xf32>
    %3 = tosa.concat %2, %2 {axis = 0 : i32} : (tensor<4xf32>, tensor<4xf32>) -> tensor<8xf32>
    %4 = tosa.reduce_min %3 {axis = 0 : i32} : (tensor<8xf32>) -> tensor<1xf32>
    %cast = tensor.cast %4 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

