module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-19> : tensor<3x6x1xi8>}> : () -> tensor<3x6x1xi8>
    %1 = "tosa.const"() <{values = dense<3> : tensor<3x1x9xi8>}> : () -> tensor<3x1x9xi8>
    %2 = "tosa.const"() <{values = dense<-3.038000e+01> : tensor<10x2xf32>}> : () -> tensor<10x2xf32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %5 = tosa.matmul %0, %1, %3, %4 : (tensor<3x6x1xi8>, tensor<3x1x9xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<3x6x9xi8>
    %6 = tosa.bitwise_or %5, %5 : (tensor<3x6x9xi8>, tensor<3x6x9xi8>) -> tensor<3x6x9xi8>
    %7 = tosa.ceil %2 : (tensor<10x2xf32>) -> tensor<10x2xf32>
    %8 = tosa.concat %6, %6 {axis = 2 : i32} : (tensor<3x6x9xi8>, tensor<3x6x9xi8>) -> tensor<3x6x18xi8>
    %9 = tosa.concat %7, %7 {axis = 1 : i32} : (tensor<10x2xf32>, tensor<10x2xf32>) -> tensor<10x4xf32>
    %cast = tensor.cast %8 : tensor<3x6x18xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %9 : tensor<10x4xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

