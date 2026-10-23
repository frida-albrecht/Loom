module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-13> : tensor<4x8xi8>}> : () -> tensor<4x8xi8>
    %1 = "tosa.const"() <{values = dense<-1.981100e+02> : tensor<8x3x2xf32>}> : () -> tensor<8x3x2xf32>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = tosa.negate %0, %2, %3 : (tensor<4x8xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<4x8xi8>
    %5 = tosa.reduce_min %4 {axis = 1 : i32} : (tensor<4x8xi8>) -> tensor<4x1xi8>
    %6 = tosa.reverse %5 {axis = 0 : i32} : (tensor<4x1xi8>) -> tensor<4x1xi8>
    %7 = tosa.reduce_min %6 {axis = 1 : i32} : (tensor<4x1xi8>) -> tensor<4x1xi8>
    %8 = tosa.reduce_min %7 {axis = 1 : i32} : (tensor<4x1xi8>) -> tensor<4x1xi8>
    %9 = tosa.exp %1 : (tensor<8x3x2xf32>) -> tensor<8x3x2xf32>
    %cast = tensor.cast %8 : tensor<4x1xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %9 : tensor<8x3x2xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

