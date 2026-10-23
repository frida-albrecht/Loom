module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<19> : tensor<4x2x7xi8>}> : () -> tensor<4x2x7xi8>
    %1 = "tosa.const"() <{values = dense<9> : tensor<4x7x7xi8>}> : () -> tensor<4x7x7xi8>
    %2 = "tosa.const"() <{values = dense<-1.614200e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %5 = tosa.matmul %0, %1, %3, %4 : (tensor<4x2x7xi8>, tensor<4x7x7xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<4x2x7xi8>
    %6 = tosa.abs %5 : (tensor<4x2x7xi8>) -> tensor<4x2x7xi8>
    %7 = tosa.abs %6 : (tensor<4x2x7xi8>) -> tensor<4x2x7xi8>
    %8 = tosa.abs %7 : (tensor<4x2x7xi8>) -> tensor<4x2x7xi8>
    %9 = tosa.reverse %8 {axis = 2 : i32} : (tensor<4x2x7xi8>) -> tensor<4x2x7xi8>
    %10 = tosa.minimum %9, %8 : (tensor<4x2x7xi8>, tensor<4x2x7xi8>) -> tensor<4x2x7xi8>
    %11 = tosa.exp %2 : (tensor<f32>) -> tensor<f32>
    %12 = tosa.rsqrt %11 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %10 : tensor<4x2x7xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %12 : tensor<f32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

