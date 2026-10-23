module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<60> : tensor<5x10xi32>}> : () -> tensor<5x10xi32>
    %1 = "tosa.const"() <{values = dense<-190> : tensor<1x1xi32>}> : () -> tensor<1x1xi32>
    %2 = "tosa.const"() <{values = dense<1.204600e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = "tosa.const"() <{values = dense<-1.233400e+02> : tensor<f32>}> : () -> tensor<f32>
    %4 = tosa.intdiv %0, %1 : (tensor<5x10xi32>, tensor<1x1xi32>) -> tensor<5x10xi32>
    %5 = tosa.reduce_sum %4 {axis = 0 : i32} : (tensor<5x10xi32>) -> tensor<1x10xi32>
    %6 = tosa.argmax %5 {axis = 0 : i32} : (tensor<1x10xi32>) -> tensor<10xi32>
    %7 = tosa.bitwise_and %6, %6 : (tensor<10xi32>, tensor<10xi32>) -> tensor<10xi32>
    %8 = tosa.logical_left_shift %7, %7 : (tensor<10xi32>, tensor<10xi32>) -> tensor<10xi32>
    %9 = tosa.pow %2, %3 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %10 = tosa.floor %9 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %8 : tensor<10xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %10 : tensor<f32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

