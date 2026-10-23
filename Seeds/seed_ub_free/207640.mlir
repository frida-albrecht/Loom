module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-156> : tensor<5xi32>}> : () -> tensor<5xi32>
    %1 = "tosa.const"() <{values = dense<184> : tensor<1xi32>}> : () -> tensor<1xi32>
    %2 = "tosa.const"() <{values = dense<-9.880000e+01> : tensor<f32>}> : () -> tensor<f32>
    %3 = tosa.intdiv %0, %1 : (tensor<5xi32>, tensor<1xi32>) -> tensor<5xi32>
    %4 = tosa.log %2 : (tensor<f32>) -> tensor<f32>
    %5 = tosa.log %4 : (tensor<f32>) -> tensor<f32>
    %6 = tosa.reduce_max %3 {axis = 0 : i32} : (tensor<5xi32>) -> tensor<1xi32>
    %7 = tosa.concat %6, %6 {axis = 0 : i32} : (tensor<1xi32>, tensor<1xi32>) -> tensor<2xi32>
    %cast = tensor.cast %5 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<2xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

