module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<19> : tensor<9x2xi8>}> : () -> tensor<9x2xi8>
    %1 = "tosa.const"() <{values = dense<-2> : tensor<9x1xi8>}> : () -> tensor<9x1xi8>
    %2 = "tosa.const"() <{values = dense<-1.515400e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = tosa.sub %0, %1 : (tensor<9x2xi8>, tensor<9x1xi8>) -> tensor<9x2xi8>
    %4 = tosa.identity %3 : (tensor<9x2xi8>) -> tensor<9x2xi8>
    %5 = tosa.rsqrt %2 : (tensor<f32>) -> tensor<f32>
    %6 = tosa.argmax %4 {axis = 0 : i32} : (tensor<9x2xi8>) -> tensor<2xi32>
    %cast = tensor.cast %5 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %6 : tensor<2xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

