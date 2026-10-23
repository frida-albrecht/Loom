module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.455000e+02> : tensor<3x4x3xf32>}> : () -> tensor<3x4x3xf32>
    %1 = "tosa.const"() <{values = dense<2> : tensor<6x7x2x7xi8>}> : () -> tensor<6x7x2x7xi8>
    %2 = tosa.reciprocal %0 : (tensor<3x4x3xf32>) -> tensor<3x4x3xf32>
    %3 = tosa.reduce_min %2 {axis = 1 : i32} : (tensor<3x4x3xf32>) -> tensor<3x1x3xf32>
    %4 = tosa.clz %1 : (tensor<6x7x2x7xi8>) -> tensor<6x7x2x7xi8>
    %5 = tosa.exp %3 : (tensor<3x1x3xf32>) -> tensor<3x1x3xf32>
    %6 = tosa.reduce_min %5 {axis = 1 : i32} : (tensor<3x1x3xf32>) -> tensor<3x1x3xf32>
    %cast = tensor.cast %4 : tensor<6x7x2x7xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %6 : tensor<3x1x3xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

