module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.067600e+02> : tensor<4x8x2xf32>}> : () -> tensor<4x8x2xf32>
    %1 = "tosa.const"() <{values = dense<17> : tensor<6x2xi8>}> : () -> tensor<6x2xi8>
    %2 = tosa.reduce_sum %0 {axis = 2 : i32} : (tensor<4x8x2xf32>) -> tensor<4x8x1xf32>
    %3 = tosa.clz %1 : (tensor<6x2xi8>) -> tensor<6x2xi8>
    %4 = tosa.reduce_max %3 {axis = 1 : i32} : (tensor<6x2xi8>) -> tensor<6x1xi8>
    %5 = tosa.identity %4 : (tensor<6x1xi8>) -> tensor<6x1xi8>
    %6 = tosa.logical_right_shift %5, %5 : (tensor<6x1xi8>, tensor<6x1xi8>) -> tensor<6x1xi8>
    %7 = tosa.logical_right_shift %6, %4 : (tensor<6x1xi8>, tensor<6x1xi8>) -> tensor<6x1xi8>
    %cast = tensor.cast %2 : tensor<4x8x1xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<6x1xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

