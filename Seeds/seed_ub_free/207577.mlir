module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<9> : tensor<1x10x5xi8>}> : () -> tensor<1x10x5xi8>
    %1 = "tosa.const"() <{values = dense<-9> : tensor<1x5x1xi8>}> : () -> tensor<1x5x1xi8>
    %2 = "tosa.const"() <{values = dense<-6.437000e+01> : tensor<3x3x2x5xf32>}> : () -> tensor<3x3x2x5xf32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %5 = tosa.matmul %0, %1, %3, %4 : (tensor<1x10x5xi8>, tensor<1x5x1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<1x10x1xi8>
    %6 = tosa.sigmoid %2 : (tensor<3x3x2x5xf32>) -> tensor<3x3x2x5xf32>
    %7 = tosa.reduce_sum %5 {axis = 2 : i32} : (tensor<1x10x1xi8>) -> tensor<1x10x1xi8>
    %cast = tensor.cast %6 : tensor<3x3x2x5xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<1x10x1xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

