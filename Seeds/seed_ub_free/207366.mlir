module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<-12> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<-146> : tensor<1xi32>}> : () -> tensor<1xi32>
    %3 = "tosa.const"() <{values = dense<-187> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = "tosa.const"() <{values = dense<-3.057000e+01> : tensor<8x9x10xf32>}> : () -> tensor<8x9x10xf32>
    %5 = tosa.bitwise_xor %0, %1 : (tensor<1xi8>, tensor<1xi8>) -> tensor<1xi8>
    %6 = tosa.intdiv %2, %3 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %7 = tosa.identity %6 : (tensor<1xi32>) -> tensor<1xi32>
    %8 = tosa.floor %4 : (tensor<8x9x10xf32>) -> tensor<8x9x10xf32>
    %9 = tosa.tanh %8 : (tensor<8x9x10xf32>) -> tensor<8x9x10xf32>
    %cast = tensor.cast %5 : tensor<1xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %7 : tensor<1xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %9 : tensor<8x9x10xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

